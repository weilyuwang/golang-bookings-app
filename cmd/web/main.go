package main

import (
	"encoding/gob"
	"flag"
	"fmt"
	"github.com/alexedwards/scs/v2"
	"github.com/weilyuwang/golang-bookings-app/internal/config"
	"github.com/weilyuwang/golang-bookings-app/internal/driver"
	"github.com/weilyuwang/golang-bookings-app/internal/handlers"
	"github.com/weilyuwang/golang-bookings-app/internal/helpers"
	"github.com/weilyuwang/golang-bookings-app/internal/models"
	"github.com/weilyuwang/golang-bookings-app/internal/render"
	"log"
	"net/http"
	"os"
	"time"
)

const portNumber = ":8080"

var app config.AppConfig
var session *scs.SessionManager
var infoLog *log.Logger
var errorLog *log.Logger

// main is the main function
func main() {
	db, err := run()
	if err != nil {
		log.Fatal(err)
	}
	defer db.SQL.Close()

	defer close(app.MailChan)

	log.Println("Starting mail listener")

	listenForMail()

	log.Println(fmt.Sprintf("Staring application on port %s", portNumber))

	srv := &http.Server{
		Addr:    portNumber,
		Handler: routes(&app),
	}

	err = srv.ListenAndServe()
	if err != nil {
		log.Fatal(err)
	}
}

func run() (*driver.DB, error) {
	// read flags
	inProduction := flag.Bool("production", true, "Application is in production")
	useCache := flag.Bool("cache", true, "Use template cache")
	dbHost := flag.String("dbhost", "localhost", "Database host")
	dbName := flag.String("dbname", "", "Database name")
	dbUser := flag.String("dbuser", "", "Database user")
	dbPass := flag.String("dbpass", "", "Database password")
	dbPort := flag.String("dbport", "5432", "Database port")
	dbSSL := flag.String("dbssl", "disable", "Database SSL settings (disable, prefer, require)")

	flag.Parse()

	if *dbName == "" || *dbUser == "" {
		fmt.Println("Missing required flags")
		os.Exit(1)
	}

	app.InProduction = *inProduction
	app.UseCache = *useCache

	infoLog = log.New(os.Stdout, "INFO\t", log.Ldate|log.Ltime)
	app.InfoLog = infoLog

	errorLog = log.New(os.Stdout, "ERROR\t", log.Ldate|log.Ltime|log.Lshortfile)
	app.ErrorLog = errorLog

	mailChan := make(chan models.MailData)
	app.MailChan = mailChan

	// what am I going to put in the session
	// Types that will be transferred as implementations of interface values need to be registered.
	gob.Register(models.Reservation{})
	gob.Register(models.User{})
	gob.Register(models.Room{})
	gob.Register(models.Restriction{})
	gob.Register(map[string]int{})

	// set up the session
	// In production, we should probably not use cookie to store session,
	// instead, we should use something like Redis, etc.
	session = scs.New()
	session.Lifetime = 24 * time.Hour
	//session.Cookie.Name = "session_id"
	session.Cookie.Persist = true
	session.Cookie.SameSite = http.SameSiteLaxMode
	session.Cookie.Secure = app.InProduction
	app.Session = session

	// connect to database
	connectionString := fmt.Sprintf(
		"host=%s port=%s dbname=%s user=%s password=%s sslmode=%s",
		*dbHost, *dbPort, *dbName, *dbUser, *dbPass, *dbSSL)

	db, err := driver.ConnectSQL(connectionString)
	if err != nil {
		log.Fatal("Cannot connect to database")
		return nil, err
	}
	log.Println("Connected to database")

	tc, err := render.CreateTemplateCache()
	if err != nil {
		log.Fatal("cannot create template cache")
		return nil, err
	}
	app.TemplateCache = tc

	repo := handlers.NewRepo(&app, db)
	handlers.NewHandlers(repo)
	render.NewRenderer(&app)
	helpers.NewHelpers(&app)

	return db, nil
}
