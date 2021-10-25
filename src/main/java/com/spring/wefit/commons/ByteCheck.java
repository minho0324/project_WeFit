package com.spring.wefit.commons;

public class ByteCheck {
	public boolean byteCheck(String txt, int standardByte) {
        if(txt.length() == 0) { return true; }
 
        // 바이트 체크 (영문 1, 한글 2, 특문 1)
        int en = 0;
        int ko = 0;
        int etc = 0;
 
        char[] txtChar = txt.toCharArray();
        for (int j = 0; j < txtChar.length; j++) {
            if (txtChar[j] >= 'A' && txtChar[j] <= 'z') {
                en++;
            } else if (txtChar[j] >= '\uAC00' && txtChar[j] <= '\uD7A3') {
                ko++;
                ko++;
            } else {
                etc++;
            }
        }
 
        int txtByte = en + ko + etc;
        if (txtByte > standardByte) {
            return false;
        } else {
            return true;
        }
 
    }


}
