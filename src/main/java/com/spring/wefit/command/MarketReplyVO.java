package com.spring.wefit.command;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/*
	CREATE TABLE MarketReply
(
    mrNum        NUMBER(10, 0)    NOT NULL, 
    mbNum        NUMBER(10, 0)    NOT NULL, 
    mrContent    VARCHAR2(200)    NOT NULL, 
    mNum        NUMBER(20, 0)    NOT NULL,
    starScore   NUMBER(2,1),
    mrRegDate    DATE             DEFAULT SYSDATE NOT NULL, 
    CONSTRAINT PK_MarketReply PRIMARY KEY (mrNum)
);

CREATE SEQUENCE marketReply_seq 
    START WITH 1 
    INCREMENT BY 1 
    MAXVALUE 10000000
    NOCYCLE 
    NOCACHE;
 */

@Getter
@Setter
@ToString
public class MarketReplyVO {

	private int mrNum;
	private int mbNum;
	private String mrContent;
	private int memberNum;
	private int starScore;
	private Timestamp mrRegDate;
	
	private String memberNick;
}
