package com.spring.wefit.command;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class FreeBoardVO {
	/*
	CREATE TABLE FreeBoard
	(
	    fbNum            NUMBER(10, 0)     NOT NULL, 
	    memberNum        NUMBER(20, 0)     NOT NULL, 
	    fbTitle          VARCHAR2(200)     NOT NULL, 
	    fbContent        VARCHAR2(2000),
	    fbImage1         VARCHAR2(50)  , 
	    fbImage2         VARCHAR2(50)  , 
	    fbImage3         VARCHAR2(50)  , 
	    fbImage4         VARCHAR2(50)  , 
	    fbImage5         VARCHAR2(50)  , 
	    fbRealImage1     VARCHAR2(50)  , 
	    fbRealImage2     VARCHAR2(50)  , 
	    fbRealImage3     VARCHAR2(50)  , 
	    fbRealImage4     VARCHAR2(50)  , 
	    fbRealImage5     VARCHAR2(50)  , 
	    fbLookCount      NUMBER(20,0)      DEFAULT 0 NOT NULL, 
	    fbImageCount     NUMBER(2,0)       NOT NULL, 
	    fbRegDate        DATE              DEFAULT SYSDATE NOT NULL, 
	    CONSTRAINT PK_FreeBoard PRIMARY KEY (fbNum)
	);
	
	CREATE SEQUENCE FreeBoard_seq 
    START WITH 1 
    INCREMENT BY 1 
    MAXVALUE 10000000 
    NOCYCLE 
    NOCACHE; 
	*/
	
	private int fbNum;
	private int memberNum;
	private String fbTitle;
	private String fbContent;
	private String fbImage1;
	private String fbImage2;
	private String fbImage3;
	private String fbImage4;
	private String fbImage5;
	private String fbRealImage1;
	private String fbRealImage2;
	private String fbRealImage3;
	private String fbRealImage4;
	private String fbRealImage5;
	private int fbLookCount;
	private int fbImageCount;
	private Timestamp fbRegDate;
	
	private String memberNick;
	private int fbLikelyCount;
	private int fbReportCount;
	private int fbReplyCount;
}
