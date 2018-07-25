package com.tqw.entity;

public class CheckARN {
    private final int prefixLen = 4;
    private final int arnoLen = 7;
    private final int suffixLen = 2;
    private final int modulus = 17;
    private final int factor = 14;

    protected static final int DTYPE_DIGIT_ONLY = 0;
    protected static final int DTYPE_LETTER_ONLY = 1;
    protected static final int DTYPE_LETTER_DIGIT = 2;

    private String prefix;
    private String arno;
    private String suffix;
    private char checkDigit;

    public CheckARN(String arn) throws Exception {
        String pf, an, sf;
        try {
            int pfStart = 0;
            int anStart = pfStart+prefixLen;
            int sfStart = anStart+arnoLen;

            pf = arn.substring(pfStart,anStart);
            an = arn.substring(anStart,sfStart);
            sf = arn.substring(sfStart);
        }
        catch (Exception e) {
            throw new Exception("Invalid ARN: arn='"+arn+"'", e);
        }
        init(pf, an, sf);
    }

    private void init(String prefix, String arno, String suffix) throws Exception {

        Exception vex = new Exception("Error");

        int sum1 = caculate(prefix, factor, DTYPE_LETTER_ONLY, false);
        int sum2 = caculate(arno, factor-prefixLen, DTYPE_DIGIT_ONLY, false);
        int sum3 = caculate(suffix, factor-prefixLen-arnoLen, DTYPE_DIGIT_ONLY, false);

        if (sum1==-1 || sum2==-1) throw vex;
        else {
            this.prefix = prefix.toUpperCase();
            this.arno = arno;
            this.suffix = suffix;
            if (sum3==-1) {
                checkDigit = ' ';
            }
            else {
                int cd = (modulus - (sum1+sum2+sum3)%modulus);
                checkDigit = getLetter(cd, modulus);
            }
        }
    }

    public char getCheckDigit() {
        return checkDigit;
    }

    public int caculate(String number, int factor, int dataType, boolean isSpaceAllowed) {

        int sum = 0;

        for (int i=0; i<number.length(); i++, factor--) {

            char c = number.charAt(i);

            if (!isSpaceAllowed || (isSpaceAllowed&&!Character.isSpaceChar(c))) {
                switch (dataType) {
                    case DTYPE_LETTER_DIGIT: if (!Character.isLetterOrDigit(c)) return -1; else break;
                    case DTYPE_LETTER_ONLY: if (!Character.isLetter(c)) return -1; else break;
                    case DTYPE_DIGIT_ONLY: if (!Character.isDigit(c)) return -1; else break;
                    default: return -1;
                }
            }
            sum += (getDigit(c)*factor);

        }

        return sum;
    }


    protected char getLetter(int i, int mod) {
        if (i > 9 && i < mod) return (char) ('A' + i - 10);
        else if (i == mod) return '0';
        else return (char) ('0' + i);
    }

    protected int getDigit(char c) {
        if (Character.isDigit(c)) {
            return c - '0';
        }
        else if (Character.isSpaceChar(c)) {
            return 36;
        }
        else {
            return Character.toUpperCase(c) - 'A' + 10;
        }
    }


}
