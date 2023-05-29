create database passport_visa_ms;
create table User_Info(
User_Id varchar(50) primary key not null,
first_name varchar(50) not null, 
last_name varchar(50) not null,
dob date not null,
address varchar(100) not null,
contact_no bigint(11) not null,
email_adderss varchar(20) not null,
qualification varchar(20) not null,
gender enum('male', 'female', 'others') not null,
apply_type enum('passport', 'visa') not null,
Hint_Question enum('que1', 'que2', 'que3', 'que4', 'que5') not null,
Hint_Answer varchar(200) not null,
citizen_type varchar(20) not null,
pass_word varchar(50) not null,
new_password VARCHAR(50)
);

CREATE TABLE Passport_Apply_Reissue (
  Passport_Id VARCHAR(50) PRIMARY KEY,
  User_Id VARCHAR(50),
  Country VARCHAR(50),
  State VARCHAR(50),
  City VARCHAR(50),
  Pin VARCHAR(10),
  Type_Of_Service VARCHAR(50),
  Reason_For_Reissue VARCHAR(255),
  Booklet_Type VARCHAR(50),
  Issue_Date DATE,
  Expiry_Date DATE,
  Temporary_Id VARCHAR(50),
  Amount_To_Be_Paid DECIMAL(10,2),
  Created_By VARCHAR(50),
  Created_Date DATE,
  Modified_By VARCHAR(50),
  Modified_Date DATE,
  FOREIGN KEY (User_Id) REFERENCES User_Info(User_Id)
);

CREATE TABLE State (
  State_Id INT PRIMARY KEY,
  State_Name VARCHAR(50),
  Created_By VARCHAR(50),
  Created_Date DATE,
  Modified_By VARCHAR(50),
  Modified_Date DATE
);


CREATE TABLE City (
  City_Id INT PRIMARY KEY,
  City_Name VARCHAR(50),
  State_Id INT,
  Created_By VARCHAR(50),
  Created_Date DATE,
  Modified_By VARCHAR(50),
  Modified_Date DATE,
  FOREIGN KEY (State_Id) REFERENCES State(State_Id)
);



CREATE TABLE Visa_Application_Cancellation (
  Visa_Id VARCHAR(50),
  User_Id VARCHAR(50) NOT NULL,
  Passport_Id VARCHAR(50) NOT NULL,
  Occupation VARCHAR(50) NOT NULL,
  Destination_Country VARCHAR(50) NOT NULL,
  Date_Of_Application DATE NOT NULL,
  Date_Of_Issue DATE NOT NULL,
  Date_Of_Expiry DATE NOT NULL,
  Registration_Cost INT,
  Cancellation_Charges INT,
  Status VARCHAR(50) NOT NULL,
  Created_By VARCHAR(50) NOT NULL,
  Created_Date DATE NOT NULL,
  Modified_By VARCHAR(50) NOT NULL,
  Modified_Date DATE NOT NULL,
  PRIMARY KEY (Visa_Id),
  FOREIGN KEY (User_Id) REFERENCES User_Info(User_Id),
  FOREIGN KEY (Passport_Id) REFERENCES Passport_Apply_Reissue(Passport_Id),
  FOREIGN KEY (Occupation) REFERENCES Occupation_Details(Occupation),
  FOREIGN KEY (Destination_Country) REFERENCES Destination_Details(Country),
  CONSTRAINT FK_Passport FOREIGN KEY (Passport_Id) REFERENCES Passport_Apply_Reissue(Passport_Id),
  CONSTRAINT CK_Visa_Id CHECK (Visa_Id <> ''),
  CONSTRAINT CK_Passport_Id CHECK (Passport_Id <> '')
);


CREATE TABLE `Destination_Details` (
  `Destination_Country` VARCHAR(50) PRIMARY KEY,
  `Created_By` VARCHAR(50) NOT NULL,
  `Created_Date` DATE NOT NULL,
  `Modified_By` VARCHAR(50) NOT NULL,
  `Modified_Date` DATE NOT NULL
);
 CREATE TABLE `Occupation_Details` (
  `Occupation` VARCHAR(50) PRIMARY KEY,
  `Created_By` VARCHAR(50) NOT NULL,
  `Created_Date` DATE NOT NULL,
  `Modified_By` VARCHAR(50) NOT NULL,
  `Modified_Date` DATE NOT NULL
);
