package com.spring.wefit.command;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/*
 /*
 
 CREATE TABLE MarketBoard
(
    mbNum            NUMBER(10, 0)     NOT NULL, 
    memberNum            NUMBER(20, 0)     NOT NULL, 
    mbType           VARCHAR2(6)       NOT NULL, 
    mbTitle          VARCHAR2(200)     NOT NULL, 
    mbPrice          NUMBER(10, 0)     NOT NULL, 
    mbContent        VARCHAR2(2000), 
    mbImage1         VARCHAR2(50)  , 
    mbImage2         VARCHAR2(50)  , 
    mbImage3         VARCHAR2(50)  , 
    mbImage4         VARCHAR2(50)  , 
    mbImage5         VARCHAR2(50)  , 
    mbImage6         VARCHAR2(50)  , 
    mbImage7         VARCHAR2(50)  , 
    mbImage8         VARCHAR2(50)  , 
    mbImage9         VARCHAR2(50)  , 
    mbImage10        VARCHAR2(50)  , 
    mbRealImage1     VARCHAR2(50)  , 
    mbRealImage2     VARCHAR2(50)  , 
    mbRealImage3     VARCHAR2(50)  , 
    mbRealImage4     VARCHAR2(50)  , 
    mbRealImage5     VARCHAR2(50)  , 
    mbRealImage6     VARCHAR2(50)  , 
    mbRealImage7     VARCHAR2(50)  , 
    mbRealImage8     VARCHAR2(50)  , 
    mbRealImage9     VARCHAR2(50)  , 
    mbRealImage10    VARCHAR2(50)  , 
    mbAddrBasic      VARCHAR(300)      NOT NULL, 
    mbLatitude       NUMBER(9, 6)      NOT NULL, 
    mbLongitude      NUMBER(9, 6)      NOT NULL, 
    mbLookCount      NUMBER(20,0)      DEFAULT 0 NOT NULL, 
    mbImageCount     NUMBER(2,0)       NOT NULL, 
    mbRegDate        DATE              DEFAULT SYSDATE NOT NULL, 
    CONSTRAINT PK_MarketBoard PRIMARY KEY (mbNum)
);

CREATE SEQUENCE marketBoard_seq 
    START WITH 1 
    INCREMENT BY 1 
    MAXVALUE 10000000 
    NOCYCLE 
    NOCACHE; 
 
 */
 
@Getter
@Setter
@ToString
public class MarketBoardVO {
	
	private int mbNum;
	private int memberNum;
	private String mbType;
	private String mbTitle;
	private int mbPrice;
	private String mbContent;
	private String mbImage1;
	private String mbImage2;
	private String mbImage3;
	private String mbImage4;
	private String mbImage5;
	private String mbImage6;
	private String mbImage7;
	private String mbImage8;
	private String mbImage9;
	private String mbImage10;
	private String mbRealImage1;
	private String mbRealImage2;
	private String mbRealImage3;
	private String mbRealImage4;
	private String mbRealImage5;
	private String mbRealImage6;
	private String mbRealImage7;
	private String mbRealImage8;
	private String mbRealImage9;
	private String mbRealImage10;
	private String mbAddrBasic;
	private String mbAddrDetail;
	private double mbLatitude;
	private double mbLongitude;
	private int mbLookCount;
	private int mbImageCount;
	private Timestamp mbRegDate;
	
	private String memberNick;
	private int mbLikelyCount;
	private int mbReportCount;
	private int mbReplyCount;
	
	
	
	
	

}
