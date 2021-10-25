package com.spring.wefit.command;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/*
 CREATE TABLE PlaceReply
(
    prNum        NUMBER(10, 0)    NOT NULL, 
    pbNum        NUMBER(10, 0)    NOT NULL, 
    prContent    VARCHAR2(200)    NOT NULL, 
    mNum        NUMBER(20, 0)    NOT NULL,
    starScore   NUMBER(2,1),
    prRegDate    DATE             DEFAULT SYSDATE NOT NULL, 
    CONSTRAINT PK_PlaceReply PRIMARY KEY (prNum)
);

CREATE SEQUENCE placeReply_seq 
    START WITH 1 
    INCREMENT BY 1 
    MAXVALUE 10000000
    NOCYCLE 
    NOCACHE;

ALTER TABLE PlaceReply ADD(memberNick VARCHAR(20));

 */
@Getter
@Setter
@ToString
public class PlaceReplyVO {

	private int prNum;
	private int pbNum;
	private String prContent;
	private int memberNum;
	private int starScore;
	private Timestamp prRegDate;
	
	private String memberNick;
	
}
