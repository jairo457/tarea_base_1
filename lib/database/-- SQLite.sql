-- SQLite
CREATE TABLE
    tblCarrera (
        IdCareer INTEGER PRIMARY KEY,
        NameCareer VARCHAR(100)
    );

CREATE TABLE
    tblProfesor (
        IdProfesor INTEGER PRIMARY KEY,
        NameProfesor VARCHAR(100),
        NameSubject VARCHAR(100),
        User VARCHAR(100),
        Contra VARCHAR(10),
        IdCareer INTEGER,
        FOREIGN KEY (IdCareer) INTEGER REFERENCES tblCarrera (IdCareer)
    );

CREATE TABLE
    tblTareas (
        IdTask INTEGER PRIMARY KEY,
        NameTask VARCHAR(50),
        DscTask VARCHAR(50),
        SttTask BYTE,
        DayTask INTEGER,
        MonthTask INTEGER,
        YearTask INTEGER,
        IdProfesor INTEGER,
        FOREIGN KEY IdProfesor INTEGER REFERENCES tblProfesor (IdProfesor)
    );

CREATE TABLE
    tblReminder (
        IdReminder INTEGER PRIMARY KEY,
        NameReminder VARCHAR(50),
        DayReminder INTEGER,
        MonthReminder INTEGER,
        YearReminder INTEGER,
        HourReminder INTEGER,
        MinuteReminder INTEGER
    );