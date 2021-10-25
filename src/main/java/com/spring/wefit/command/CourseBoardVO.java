package com.spring.wefit.command;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/*
 
CREATE TABLE CourseBoard
(
    cbNum            NUMBER(10, 0)     NOT NULL, 
    mNum            NUMBER(20, 0)     NOT NULL, 
    cbTitle          VARCHAR2(200)     NOT NULL, 
    cbContent        VARCHAR2(2000), 
    cbYouCode      VARCHAR(50)      NOT NULL, 
    cbCategory      VARCHAR(20)      NOT NULL, 
    cbLookCount      NUMBER(20,0)      DEFAULT 0 NOT NULL, 
    cbRegDate        DATE              DEFAULT SYSDATE NOT NULL, 
    CONSTRAINT PK_CourseBoard PRIMARY KEY (cbNum)
);

CREATE SEQUENCE courseBoard_seq 
    START WITH 1 
    INCREMENT BY 1 
    MAXVALUE 10000000 
    NOCYCLE 
    NOCACHE; 
    
*/

@Getter
@Setter
@ToString
public class CourseBoardVO {
	
	private int cbNum;
	private int memberNum;
	private String cbTitle;
	private String cbContent;
	private String cbYouCode;
	private String cbCategory;
	private int cbLookCount;
	private Timestamp cbRegDate;
	
	private int crCount;
	
	private int cbTitleByte;
	private int cbContentByte;
	private int cbYouCodeByte;
	private int cbReportCount;

}
