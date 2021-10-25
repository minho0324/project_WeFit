package com.spring.wefit.command;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/*
 
 CREATE TABLE Member
(
    mNum           NUMBER(20, 0)    NOT NULL, 
    mEmail         VARCHAR2(30)     NOT NULL, 
    mNick          VARCHAR2(30)     NOT NULL, 
    mPasswd        VARCHAR2(100)    NOT NULL, 
    mPhone         VARCHAR2(30), 
    mRegistDate    DATE             DEFAULT sysdate NOT NULL, 
    mConnDate      DATE             DEFAULT sysdate NOT NULL, 
    mHumanYN       VARCHAR2(10)     NOT NULL, 
    mLatitude      NUMBER(9, 6), 
    mLongitude     NUMBER(9, 6), 
    mEmailYN       VARCHAR2(10)     NOT NULL, 
    mCode          VARCHAR2(20)     NOT NULL, 
    mManagerYN     VARCHAR2(10)     DEFAULT 'NO' NOT NULL, 
    mDelDate       DATE,
    sessionId      VARCHAR2(80)     DEFAULT 'none' NOT NULL,
    autoLoginLimit DATE,
    CONSTRAINT PK_Member PRIMARY KEY (mNum)
);

CREATE SEQUENCE member_seq 
    START WITH 1 
    INCREMENT BY 1 
    MAXVALUE 10000000
    NOCYCLE 
    NOCACHE;
 
 */


@Getter
@Setter
@ToString
public class UserVO {
	private int memberNum;
    private String memberEmail;
    private String memberNick;
    private String memberPasswd;
    private String memberPhone;
    private Timestamp memberRegistDate;
    private Timestamp memberConnDate;
    private String memberHumanYN;
    private double memberLatitude;
    private double memberLongitude;
    private String memberEmailYN;
    private String memberCode;
    private String memberManagerYN;
    private Timestamp memberDelDate;
    private String sessionId;
    private Timestamp autoLoginLimit;
    
    
    private boolean autoLoginCheck;
}
