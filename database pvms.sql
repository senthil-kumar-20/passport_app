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
  CONSTRAINT CK_Date_Of_Application CHECK (Date_Of_Application >= CURDATE()),
  CONSTRAINT CK_Date_Of_Expiry CHECK (Date_Of_Expiry >= Date_Of_Issue),
  CONSTRAINT CK_Visa_Expiry CHECK (Date_Of_Expiry >= CURDATE()),
  CONSTRAINT CK_Visa_Id CHECK (Visa_Id <> ''),
  CONSTRAINT CK_Passport_Id CHECK (Passport_Id <> '')
);

DELIMITER //

CREATE TRIGGER trg_Check_Expiry
BEFORE INSERT ON Visa_Application_Cancellation
FOR EACH ROW
BEGIN
  DECLARE passport_expiry DATE;
  SET passport_expiry = (SELECT Date_Of_Expiry FROM Passport_Apply_Reissue WHERE Passport_Id = NEW.Passport_Id);
  
  IF NEW.Date_Of_Expiry < passport_expiry THEN
    SET NEW.Date_Of_Expiry = passport_expiry;
  END IF;
END//

CREATE TRIGGER trg_Check_Visa_Passport_Id
BEFORE INSERT ON Visa_Application_Cancellation
FOR EACH ROW
BEGIN
  DECLARE alphanumeric_pattern VARCHAR(100);
  SET alphanumeric_pattern = '^[A-Za-z0-9]+$';

  IF NEW.Visa_Id NOT REGEXP alphanumeric_pattern OR NEW.Passport_Id NOT REGEXP alphanumeric_pattern THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid Visa_Id or Passport_Id';
  END IF;
END//

CREATE TRIGGER trg_Check_Passport_User_Id
BEFORE INSERT ON Visa_Application_Cancellation
FOR EACH ROW
BEGIN
  DECLARE matching_passport_id VARCHAR(50);
  SET matching_passport_id = (SELECT Passport_Id FROM User_Info WHERE User_Id = NEW.User_Id);
  
  IF NEW.Passport_Id <> matching_passport_id THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Passport_Id does not match with User_Id';
  END IF;
END//

CREATE TRIGGER trg_Check_Visa_Expiry
BEFORE INSERT ON Visa_Application_Cancellation
FOR EACH ROW
BEGIN
  IF NEW.Date_Of_Expiry < CURDATE() THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Visa has already expired';
  END IF;
END//

DELIMITER ;

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
