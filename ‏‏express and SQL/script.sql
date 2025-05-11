--create database Library_25
--go

--use Library_25
--go

-- יצירת טבלת משתמשים
CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1), -- מזהה ייחודי למשתמש, נוצר אוטומטית
    Name NVARCHAR(100) NOT NULL,         -- שם המשתמש (תומך בעברית)
    Email NVARCHAR(255) NOT NULL UNIQUE,  -- כתובת אימייל (ייחודית)
    PasswordHash NVARCHAR(255) NOT NULL,  -- סיסמה (יש לאחסן האש של הסיסמה ולא את הסיסמה עצמה)
    Role NVARCHAR(50) NOT NULL,          -- תפקיד המשתמש (למשל, 'Admin', 'Member')
    IsActive BIT NOT NULL DEFAULT 1      -- האם המשתמש פעיל (ברירת מחדל: פעיל)
);
GO

-- הוספת הערות לטבלת משתמשים
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'טבלת משתמשים במערכת' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Users';
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'מזהה ייחודי של המשתמש' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Users', @level2type=N'COLUMN',@level2name=N'UserID';
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'שם מלא של המשתמש (תומך בעברית)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Users', @level2type=N'COLUMN',@level2name=N'Name';
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'כתובת אימייל של המשתמש (חייבת להיות ייחודית)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Users', @level2type=N'COLUMN',@level2name=N'Email';
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'האש של סיסמת המשתמש' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Users', @level2type=N'COLUMN',@level2name=N'PasswordHash';
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'תפקיד המשתמש במערכת' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Users', @level2type=N'COLUMN',@level2name=N'Role';
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'האם חשבון המשתמש פעיל (1=פעיל, 0=לא פעיל)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Users', @level2type=N'COLUMN',@level2name=N'IsActive';
GO

-- יצירת טבלת ספרים
CREATE TABLE Books (
    BookID INT PRIMARY KEY IDENTITY(1,1),  -- מזהה ייחודי לספר, נוצר אוטומטית
    Title NVARCHAR(255) NOT NULL,        -- כותרת הספר (תומך בעברית)
    Author NVARCHAR(150) NOT NULL,       -- מחבר הספר (תומך בעברית)
    Genre NVARCHAR(100),                 -- ז'אנר הספר (תומך בעברית)
    PublishedYear INT,                   -- שנת הוצאה לאור
    IsDeleted BIT NOT NULL DEFAULT 0     -- האם הספר נמחק (ברירת מחדל: לא נמחק)
);
GO

-- הוספת הערות לטבלת ספרים
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'טבלת ספרים במערכת' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Books';
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'מזהה ייחודי של הספר' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Books', @level2type=N'COLUMN',@level2name=N'BookID';
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'כותרת הספר (תומך בעברית)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Books', @level2type=N'COLUMN',@level2name=N'Title';
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'שם מחבר הספר (תומך בעברית)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Books', @level2type=N'COLUMN',@level2name=N'Author';
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ז''אנר הספר (תומך בעברית)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Books', @level2type=N'COLUMN',@level2name=N'Genre';
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'שנת ההוצאה לאור של הספר' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Books', @level2type=N'COLUMN',@level2name=N'PublishedYear';
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'האם הספר סומן כמחוק (1=מחוק, 0=לא מחוק)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Books', @level2type=N'COLUMN',@level2name=N'IsDeleted';
GO

-- יצירת טבלת השאלות (טבלה מקשרת)
CREATE TABLE Borrows (
    BorrowID INT IDENTITY(1,1), -- מזהה ייחודי להשאלה, נוצר אוטומטית
    UserID INT NOT NULL,                  -- מזהה המשתמש ששאל (מפתח זר לטבלת Users)
    BookID INT NOT NULL,                  -- מזהה הספר שנשאל (מפתח זר לטבלת Books)
    BorrowDate DATETIME NOT NULL DEFAULT GETDATE(), -- תאריך ושעת ההשאלה (ברירת מחדל: התאריך והשעה הנוכחיים)
    ReturnDate DATETIME NULL,             -- תאריך ושעת ההחזרה (יכול להיות ריק אם הספר עדיין מושאל)
    IsReturned BIT NOT NULL DEFAULT 0,    -- האם הספר הוחזר (ברירת מחדל: לא הוחזר)

	--

    -- הגדרת מפתחות זרים
    CONSTRAINT FK_Borrows_Users FOREIGN KEY (UserID) REFERENCES Users(UserID),
    CONSTRAINT FK_Borrows_Books FOREIGN KEY (BookID) REFERENCES Books(BookID)
);
GO

-- הוספת אינדקסים לשיפור ביצועים בשאילתות נפוצות
CREATE INDEX IX_Borrows_UserID ON Borrows(UserID);
CREATE INDEX IX_Borrows_BookID ON Borrows(BookID);
CREATE INDEX IX_Borrows_ReturnDate ON Borrows(ReturnDate) WHERE ReturnDate IS NULL; -- לאיתור ספרים שעדיין מושאלים
GO

-- הוספת הערות לטבלת השאלות
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'טבלת השאלות המקשרת בין משתמשים לספרים' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Borrows';
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'מזהה ייחודי של פעולת ההשאלה' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Borrows', @level2type=N'COLUMN',@level2name=N'BorrowID';
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'מזהה המשתמש שביצע את ההשאלה' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Borrows', @level2type=N'COLUMN',@level2name=N'UserID';
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'מזהה הספר שהושאל' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Borrows', @level2type=N'COLUMN',@level2name=N'BookID';
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'תאריך ושעת ההשאלה' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Borrows', @level2type=N'COLUMN',@level2name=N'BorrowDate';
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'תאריך ושעת החזרת הספר (אם הוחזר)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Borrows', @level2type=N'COLUMN',@level2name=N'ReturnDate';
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'האם הספר הוחזר (1=הוחזר, 0=לא הוחזר)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Borrows', @level2type=N'COLUMN',@level2name=N'IsReturned';
GO


-- ==========================================================================================
-- פרוצדורות עבור טבלת משתמשים (Users)
-- ==========================================================================================
GO

--------------------------------------------------------------------------------------------
-- יצירת משתמש חדש
--------------------------------------------------------------------------------------------
CREATE PROCEDURE dbo.usp_CreateUser
    @Name NVARCHAR(100),
    @Email NVARCHAR(255),
    @PasswordHash NVARCHAR(255),
    @Role NVARCHAR(50),
    @UserID_OUT INT OUTPUT -- פרמטר פלט להחזרת המזהה של המשתמש החדש
AS
BEGIN
    SET NOCOUNT ON;

    -- בדיקה אם האימייל כבר קיים
    IF EXISTS (SELECT 1 FROM dbo.Users WHERE Email = @Email)
    BEGIN
        RAISERROR('כתובת אימייל כבר קיימת במערכת.', 16, 1);
        RETURN;
    END

    BEGIN TRY
        INSERT INTO dbo.Users (Name, Email, PasswordHash, Role, IsActive)
        VALUES (@Name, @Email, @PasswordHash, @Role, 1); -- משתמש חדש פעיל כברירת מחדל

        SET @UserID_OUT = SCOPE_IDENTITY(); -- קבלת המזהה של הרשומה החדשה
    END TRY
    BEGIN CATCH
        -- טיפול בשגיאות כלליות אם ההוספה נכשלה
        THROW;
    END CATCH
END
GO

--------------------------------------------------------------------------------------------
-- שליפת משתמש לפי מזהה
--------------------------------------------------------------------------------------------
CREATE PROCEDURE dbo.usp_GetUserByID
    @UserID INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT UserID, Name, Email, Role, IsActive
    FROM dbo.Users
    WHERE UserID = @UserID;
END
GO

--------------------------------------------------------------------------------------------
-- שליפת כל המשתמשים (או משתמשים פעילים/לא פעילים)
--------------------------------------------------------------------------------------------
CREATE PROCEDURE dbo.usp_GetUsers
    @IsActive BIT = NULL -- פרמטר אופציונלי לסינון לפי סטטוס פעילות
AS
BEGIN
    SET NOCOUNT ON;
    SELECT UserID, Name, Email, Role, IsActive
    FROM dbo.Users
    WHERE (@IsActive IS NULL OR IsActive = @IsActive);
END
GO

--------------------------------------------------------------------------------------------
-- עדכון פרטי משתמש
--------------------------------------------------------------------------------------------
CREATE PROCEDURE dbo.usp_UpdateUser
    @UserID INT,
    @Name NVARCHAR(100),
    @Email NVARCHAR(255),
    @PasswordHash NVARCHAR(255) = NULL, -- סיסמה אופציונלית לעדכון
    @Role NVARCHAR(50),
    @IsActive BIT
AS
BEGIN
    SET NOCOUNT ON;

    -- בדיקה אם המשתמש קיים
    IF NOT EXISTS (SELECT 1 FROM dbo.Users WHERE UserID = @UserID)
    BEGIN
        RAISERROR('משתמש עם המזהה שסופק אינו קיים.', 16, 1);
        RETURN;
    END

    -- בדיקה אם האימייל החדש (אם שונה) כבר תפוס על ידי משתמש אחר
    IF EXISTS (SELECT 1 FROM dbo.Users WHERE Email = @Email AND UserID <> @UserID)
    BEGIN
        RAISERROR('כתובת אימייל כבר קיימת עבור משתמש אחר.', 16, 1);
        RETURN;
    END

    BEGIN TRY
        UPDATE dbo.Users
        SET Name = @Name,
            Email = @Email,
            PasswordHash = ISNULL(@PasswordHash, PasswordHash), -- עדכן סיסמה רק אם סופקה
            Role = @Role,
            IsActive = @IsActive
        WHERE UserID = @UserID;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO

--------------------------------------------------------------------------------------------
-- מחיקת משתמש (מחיקה רכה - סימון כלא פעיל)
--------------------------------------------------------------------------------------------
CREATE PROCEDURE dbo.usp_DeleteUser
    @UserID INT
AS
BEGIN
    SET NOCOUNT ON;

    -- בדיקה אם המשתמש קיים
    IF NOT EXISTS (SELECT 1 FROM dbo.Users WHERE UserID = @UserID)
    BEGIN
        RAISERROR('משתמש עם המזהה שסופק אינו קיים.', 16, 1);
        RETURN;
    END

    BEGIN TRY
        UPDATE dbo.Users
        SET IsActive = 0 -- סימון כלא פעיל
        WHERE UserID = @UserID;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO

-- ==========================================================================================
-- פרוצדורות עבור טבלת ספרים (Books)
-- ==========================================================================================
GO

--------------------------------------------------------------------------------------------
-- יצירת ספר חדש
--------------------------------------------------------------------------------------------
CREATE PROCEDURE dbo.usp_CreateBook
    @Title NVARCHAR(255),
    @Author NVARCHAR(150),
    @Genre NVARCHAR(100) = NULL,
    @PublishedYear INT = NULL,
    @BookID_OUT INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        INSERT INTO dbo.Books (Title, Author, Genre, PublishedYear, IsDeleted)
        VALUES (@Title, @Author, @Genre, @PublishedYear, 0); -- ספר חדש אינו מחוק כברירת מחדל

        SET @BookID_OUT = SCOPE_IDENTITY();
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO

--------------------------------------------------------------------------------------------
-- שליפת ספר לפי מזהה
--------------------------------------------------------------------------------------------
CREATE PROCEDURE dbo.usp_GetBookByID
    @BookID INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT BookID, Title, Author, Genre, PublishedYear, IsDeleted
    FROM dbo.Books
    WHERE BookID = @BookID;
END
GO

--------------------------------------------------------------------------------------------
-- שליפת כל הספרים (או לפי סטטוס מחיקה, מחבר, ז'אנר)
--------------------------------------------------------------------------------------------
CREATE PROCEDURE dbo.usp_GetBooks
    @IsDeleted BIT = 0, -- ברירת מחדל: הצג ספרים שאינם מחוקים
    @Author NVARCHAR(150) = NULL,
    @Genre NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SELECT BookID, Title, Author, Genre, PublishedYear, IsDeleted
    FROM dbo.Books
    WHERE (IsDeleted = @IsDeleted)
      AND (@Author IS NULL OR Author LIKE '%' + @Author + '%')
      AND (@Genre IS NULL OR Genre LIKE '%' + @Genre + '%');
END
GO

--------------------------------------------------------------------------------------------
-- עדכון פרטי ספר
--------------------------------------------------------------------------------------------
CREATE PROCEDURE dbo.usp_UpdateBook
    @BookID INT,
    @Title NVARCHAR(255),
    @Author NVARCHAR(150),
    @Genre NVARCHAR(100) = NULL,
    @PublishedYear INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM dbo.Books WHERE BookID = @BookID)
    BEGIN
        RAISERROR('ספר עם המזהה שסופק אינו קיים.', 16, 1);
        RETURN;
    END

    BEGIN TRY
        UPDATE dbo.Books
        SET Title = @Title,
            Author = @Author,
            Genre = @Genre,
            PublishedYear = @PublishedYear
        WHERE BookID = @BookID;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO

--------------------------------------------------------------------------------------------
-- מחיקת ספר (מחיקה רכה - סימון כמחוק)
--------------------------------------------------------------------------------------------
CREATE PROCEDURE dbo.usp_DeleteBook
    @BookID INT
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM dbo.Books WHERE BookID = @BookID)
    BEGIN
        RAISERROR('ספר עם המזהה שסופק אינו קיים.', 16, 1);
        RETURN;
    END

    -- בדיקה אם הספר מושאל כרגע
    IF EXISTS (SELECT 1 FROM dbo.Borrows WHERE BookID = @BookID AND IsReturned = 0)
    BEGIN
        RAISERROR('לא ניתן למחוק ספר שמושאל כרגע.', 16, 1);
        RETURN;
    END

    BEGIN TRY
        UPDATE dbo.Books
        SET IsDeleted = 1 -- סימון כמחוק
        WHERE BookID = @BookID;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO

-- ==========================================================================================
-- פרוצדורות עבור טבלת השאלות (Borrows)
-- ==========================================================================================
GO

--------------------------------------------------------------------------------------------
-- יצירת השאלה חדשה (השאלת ספר)
--------------------------------------------------------------------------------------------
CREATE PROCEDURE dbo.usp_CreateBorrow
    @UserID INT,
    @BookID INT,
    @BorrowID_OUT INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    -- בדיקה אם המשתמש קיים ופעיל
    IF NOT EXISTS (SELECT 1 FROM dbo.Users WHERE UserID = @UserID AND IsActive = 1)
    BEGIN
        RAISERROR('משתמש אינו קיים או אינו פעיל.', 16, 1);
        RETURN;
    END

    -- בדיקה אם הספר קיים ואינו מחוק
    IF NOT EXISTS (SELECT 1 FROM dbo.Books WHERE BookID = @BookID AND IsDeleted = 0)
    BEGIN
        RAISERROR('ספר אינו קיים או סומן כמחוק.', 16, 1);
        RETURN;
    END

    -- בדיקה אם הספר כבר מושאל על ידי מישהו אחר ועדיין לא הוחזר
    IF EXISTS (SELECT 1 FROM dbo.Borrows WHERE BookID = @BookID AND IsReturned = 0)
    BEGIN
        RAISERROR('הספר כבר מושאל כרגע ועדיין לא הוחזר.', 16, 1);
        RETURN;
    END

    BEGIN TRY
        INSERT INTO dbo.Borrows (UserID, BookID, BorrowDate, ReturnDate, IsReturned)
        VALUES (@UserID, @BookID, GETDATE(), NULL, 0); -- תאריך החזרה ריק, סטטוס לא הוחזר

        SET @BorrowID_OUT = SCOPE_IDENTITY();
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO

--------------------------------------------------------------------------------------------
-- שליפת השאלה לפי מזהה
--------------------------------------------------------------------------------------------
CREATE PROCEDURE dbo.usp_GetBorrowByID
    @BorrowID INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT BorrowID, UserID, BookID, BorrowDate, ReturnDate, IsReturned
    FROM dbo.Borrows
    WHERE BorrowID = @BorrowID;
END
GO

--------------------------------------------------------------------------------------------
-- שליפת כל ההשאלות של משתמש מסוים
--------------------------------------------------------------------------------------------
CREATE PROCEDURE dbo.usp_GetBorrowsByUserID
    @UserID INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT b.BorrowID, b.BookID, bk.Title AS BookTitle, b.BorrowDate, b.ReturnDate, b.IsReturned
    FROM dbo.Borrows b
    JOIN dbo.Books bk ON b.BookID = bk.BookID
    WHERE b.UserID = @UserID
    ORDER BY b.BorrowDate DESC;
END
GO

--------------------------------------------------------------------------------------------
-- שליפת כל ההשאלות של ספר מסוים (היסטוריית השאלות)
--------------------------------------------------------------------------------------------
CREATE PROCEDURE dbo.usp_GetBorrowsByBookID
    @BookID INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT b.BorrowID, b.UserID, u.Name AS UserName, b.BorrowDate, b.ReturnDate, b.IsReturned
    FROM dbo.Borrows b
    JOIN dbo.Users u ON b.UserID = u.UserID
    WHERE b.BookID = @BookID
    ORDER BY b.BorrowDate DESC;
END
GO

--------------------------------------------------------------------------------------------
-- שליפת כל ההשאלות הפעילות (ספרים שעדיין לא הוחזרו)
--------------------------------------------------------------------------------------------
CREATE PROCEDURE dbo.usp_GetActiveBorrows
AS
BEGIN
    SET NOCOUNT ON;
    SELECT b.BorrowID, b.UserID, u.Name AS UserName, b.BookID, bk.Title AS BookTitle, b.BorrowDate
    FROM dbo.Borrows b
    JOIN dbo.Users u ON b.UserID = u.UserID
    JOIN dbo.Books bk ON b.BookID = bk.BookID
    WHERE b.IsReturned = 0
    ORDER BY b.BorrowDate ASC;
END
GO

--------------------------------------------------------------------------------------------
-- עדכון השאלה - סימון ספר כהוחזר
--------------------------------------------------------------------------------------------
CREATE PROCEDURE dbo.usp_UpdateBorrowReturn
    @BorrowID INT,
    @ReturnDate DATETIME = NULL -- אם לא מסופק, ישתמש בתאריך הנוכחי
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM dbo.Borrows WHERE BorrowID = @BorrowID)
    BEGIN
        RAISERROR('רשומת השאלה עם המזהה שסופק אינה קיימת.', 16, 1);
        RETURN;
    END

    IF EXISTS (SELECT 1 FROM dbo.Borrows WHERE BorrowID = @BorrowID AND IsReturned = 1)
    BEGIN
        RAISERROR('הספר כבר סומן כמוחזר.', 16, 1);
        RETURN;
    END

    BEGIN TRY
        UPDATE dbo.Borrows
        SET IsReturned = 1,
            ReturnDate = ISNULL(@ReturnDate, GETDATE()) -- אם לא סופק תאריך החזרה, השתמש בתאריך הנוכחי
        WHERE BorrowID = @BorrowID;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO

--------------------------------------------------------------------------------------------
-- מחיקת רשומת השאלה (מחיקה פיזית)
-- יש לשקול אם נדרשת מחיקה רכה לצורכי ביקורת
--------------------------------------------------------------------------------------------
CREATE PROCEDURE dbo.usp_DeleteBorrow
    @BorrowID INT
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM dbo.Borrows WHERE BorrowID = @BorrowID)
    BEGIN
        RAISERROR('רשומת השאלה עם המזהה שסופק אינה קיימת.', 16, 1);
        RETURN;
    END

    -- אופציונלי: ניתן להוסיף בדיקה אם ההשאלה פעילה ולא לאפשר מחיקה
    -- IF EXISTS (SELECT 1 FROM dbo.Borrows WHERE BorrowID = @BorrowID AND IsReturned = 0)
    -- BEGIN
    --     RAISERROR('לא ניתן למחוק רשומת השאלה פעילה. יש לסמן תחילה את הספר כמוחזר.', 16, 1);
    --     RETURN;
    -- END

    BEGIN TRY
        DELETE FROM dbo.Borrows
        WHERE BorrowID = @BorrowID;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO


-- ==========================================================================================
-- הוספת נתונים לדוגמה לטבלת משתמשים (Users)
-- ==========================================================================================
-- הערה: בסביבת ייצור, יש להשתמש בפונקציית האשינג לאחסון סיסמאות.
-- לדוגמה: HASHBYTES('SHA2_256', 'סיסמה123')

-- משתמש 1
INSERT INTO dbo.Users (Name, Email, PasswordHash, Role, IsActive)
VALUES (N'ישראל ישראלי', N'israel@example.com', N'Password123Hash', N'Admin', 1);

-- משתמש 2
INSERT INTO dbo.Users (Name, Email, PasswordHash, Role, IsActive)
VALUES (N'יעל כהן', N'yael.cohen@example.com', N'SecurePassHash', N'Member', 1);

-- משתמש 3
INSERT INTO dbo.Users (Name, Email, PasswordHash, Role, IsActive)
VALUES (N'משה לוי', N'moshe@example.com', N'AnotherHash1!', N'Member', 1);

-- משתמש 4
INSERT INTO dbo.Users (Name, Email, PasswordHash, Role, IsActive)
VALUES (N'שרה שרון', N'sara.sharon@example.co.il', N'PassHashValue', N'Member', 0); -- משתמש לא פעיל

-- משתמש 5
INSERT INTO dbo.Users (Name, Email, PasswordHash, Role, IsActive)
VALUES (N'דוד דוידי', N'david.d@example.org', N'MySecretHash', N'Librarian', 1);
GO

-- ==========================================================================================
-- הוספת נתונים לדוגמה לטבלת ספרים (Books)
-- ==========================================================================================

-- ספר 1
INSERT INTO dbo.Books (Title, Author, Genre, PublishedYear, IsDeleted)
VALUES (N'התפסן בשדה השיפון', N'ג''רום דייוויד סלינג''ר', N'ספרות יפה', 1951, 0);

-- ספר 2
INSERT INTO dbo.Books (Title, Author, Genre, PublishedYear, IsDeleted)
VALUES (N'1984', N'ג''ורג'' אורוול', N'דיסטופיה', 1949, 0);

-- ספר 3
INSERT INTO dbo.Books (Title, Author, Genre, PublishedYear, IsDeleted)
VALUES (N'אלכימאי', N'פאולו קואלו', N'פנטזיה', 1988, 0);

-- ספר 4
INSERT INTO dbo.Books (Title, Author, Genre, PublishedYear, IsDeleted)
VALUES (N'קיצור תולדות האנושות', N'יובל נח הררי', N'היסטוריה', 2011, 0);

-- ספר 5
INSERT INTO dbo.Books (Title, Author, Genre, PublishedYear, IsDeleted)
VALUES (N'הארי פוטר ואבן החכמים', N'ג''יי קיי רולינג', N'פנטזיה', 1997, 1); -- ספר שסומן כמחוק
GO

-- ==========================================================================================
-- הוספת נתונים לדוגמה לטבלת השאלות (Borrows)
-- ==========================================================================================
-- הנחה: UserID ו-BookID קיימים מההוספות הקודמות.
-- UserIDs: 1 (ישראל), 2 (יעל), 3 (משה), 5 (דוד)
-- BookIDs: 1 (התפסן), 2 (1984), 3 (אלכימאי), 4 (קיצור תולדות)

-- השאלה 1: ישראל שאל את "התפסן בשדה השיפון" והחזיר
INSERT INTO dbo.Borrows (UserID, BookID, BorrowDate, ReturnDate, IsReturned)
VALUES (1, 1, DATEADD(day, -30, GETDATE()), DATEADD(day, -15, GETDATE()), 1);

-- השאלה 2: יעל שאלה את "1984" ועדיין לא החזירה
INSERT INTO dbo.Borrows (UserID, BookID, BorrowDate, ReturnDate, IsReturned)
VALUES (2, 2, DATEADD(day, -10, GETDATE()), NULL, 0);

-- השאלה 3: משה שאל את "אלכימאי" והחזיר
INSERT INTO dbo.Borrows (UserID, BookID, BorrowDate, ReturnDate, IsReturned)
VALUES (3, 3, DATEADD(month, -2, GETDATE()), DATEADD(month, -2, GETDATE()), 1);

-- השאלה 4: ישראל שאל את "קיצור תולדות האנושות" ועדיין לא החזיר
INSERT INTO dbo.Borrows (UserID, BookID, BorrowDate, ReturnDate, IsReturned)
VALUES (1, 4, DATEADD(day, -5, GETDATE()), NULL, 0);

-- השאלה 5: דוד (הספרן) שאל את "1984" בעבר (לאחר שיעל תחזיר, לצורך הדוגמה נניח שהוא הוחזר והושאל שוב)
-- כדי שזה יעבוד, נצטרך לוודא שספר 2 פנוי. נניח שההשאלה של יעל הסתיימה.
-- אם רוצים להדגים השאלה נוספת של ספר 2, יש לעדכן את ההשאלה של יעל ל-IsReturned = 1.
-- לחלופין, נשאיל ספר אחר לדוד. נשתמש בספר 1 (התפסן) שוב, כיוון שהוא הוחזר.
INSERT INTO dbo.Borrows (UserID, BookID, BorrowDate, ReturnDate, IsReturned)
VALUES (5, 1, DATEADD(day, -3, GETDATE()), NULL, 0);
GO


