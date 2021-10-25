package com.spring.wefit.command;
/*
 * CREATE TABLE DietBoard ( 
dbNum NUMBER(10, 0) NOT NULL, 
memberNum NUMBER(20, 0) NOT NULL, 
memberNick VARCHAR2(30) NOT NULL, 
dbTitle VARCHAR2(200) NOT NULL, 
dbContent VARCHAR2(2000), 
dbImage1 VARCHAR2(50) , 
dbImage2 VARCHAR2(50) , 
dbImage3 VARCHAR2(50) , 
dbImage4 VARCHAR2(50) , 
dbImage5 VARCHAR2(50) , 
dbRealImage1 VARCHAR2(50) , 
dbRealImage2 VARCHAR2(50) , 
dbRealImage3 VARCHAR2(50) , 
dbRealImage4 VARCHAR2(50) , 
dbRealImage5 VARCHAR2(50) , 
dbLookCount NUMBER(20,0) DEFAULT 0 , 
dbImageCount NUMBER(2,0) DEFAULT 0 , 
dbRegDate DATE DEFAULT SYSDATE NOT NULL, 
CONSTRAINT PK_DietBoard PRIMARY KEY (dbNum) );
 * */

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class DietBoardVO {
	
	private int dbNum;
	private int memberNum;
	private String dbTitle;
	private String dbContent;
	private String dbImage1;
	private String dbImage2;
	private String dbImage3;
	private String dbImage4;
	private String dbImage5;
	private String dbRealImage1;
	private String dbRealImage2;
	private String dbRealImage3;
	private String dbRealImage4;
	private String dbRealImage5;
	private int dbLookCount;
	private int dbImageCount;
	private Timestamp dbRegDate;
	private String memberNick;
	private int drCount;
	private int dbReportCount;
	
    private int dbTitleByte;
	private int dbContentByte;
	
/*
CREATE TABLE DietBoard
(
    dbNum            NUMBER(10, 0)     NOT NULL, 
    mNum            NUMBER(20, 0)     NOT NULL, 
    dbTitle          VARCHAR2(200)     NOT NULL, 
    dbContent        VARCHAR2(2000), 
    dbImage1         VARCHAR2(50)  , 
    dbImage2         VARCHAR2(50)  , 
    dbImage3         VARCHAR2(50)  , 
    dbImage4         VARCHAR2(50)  , 
    dbImage5         VARCHAR2(50)  , 
    dbRealImage1     VARCHAR2(50)  , 
    dbRealImage2     VARCHAR2(50)  , 
    dbRealImage3     VARCHAR2(50)  , 
    dbRealImage4     VARCHAR2(50)  , 
    dbRealImage5     VARCHAR2(50)  , 
    dbLookCount      NUMBER(20,0)      DEFAULT 0 NOT NULL, 
    dbImageCount     NUMBER(2,0)       NOT NULL, 
    dbRegDate        DATE              DEFAULT SYSDATE NOT NULL, 
    nickName		 VARCHAR2(30) NOT NULL
    CONSTRAINT PK_DietBoard PRIMARY KEY (dbNum)
);


CREATE SEQUENCE dietBoard_seq 
    START WITH 1 
    INCREMENT BY 1 
    MAXVALUE 10000000 
    NOCYCLE 
    NOCACHE; 
*/



	

	
	
	
	
	
	
}








