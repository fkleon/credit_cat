 library credit_cat_test;

 import 'dart:convert' show JSON;
 import 'package:credit_cat/credit_cat.dart';
 import 'package:unittest/unittest.dart';

 main() {
  test("Should remove any dashs and space from the credit card number", () {
    var cat = new creditCat("1-2-3-2-1 3-2-1-7");
    expect(cat.cardNumber, equals("123213217"));
  });

  test("Should remove anything based on the RegExp from the credit card number", () {
    var cat = new creditCat.clean("1*2*3*2*1*3*2*1*7", new RegExp(r"\*"));
    expect(cat.cardNumber, equals("123213217"));
  });

  test("Should throw error when string is not a number", () {
    expect(() => new creditCat("Not a Number"),throwsFormatException);
  });

  test("Should throw error when string is empty", () {
    expect(() => new creditCat(""),throwsFormatException);
  });

  test("Should return true for a valid credit card number", () {
    var cat = new creditCat("123213217");
    expect(cat.valid, equals(true));
  });

  test("Should return true for a valid credit card number", () {
    var cat = new creditCat("12321321");
    expect(cat.valid, equals(false));
  });

  test("Should return the right industry name", () {
    var cat1 = new creditCat("312321321");
    expect(cat1.cardIndustry, equals(Industries.TRAVEL_AND_ENTERTAINMENT));

    var cat2 = new creditCat("412321321");
    expect(cat2.cardIndustry, equals(Industries.BANKING_AND_FINANCIAL));

    var cat3 = new creditCat("512321321");
    expect(cat3.cardIndustry, equals(Industries.BANKING_AND_FINANCIAL));
  });

  test("Should return the right issuer name for Visa", () {
    var cat1 = new creditCat("400000");
    expect(cat1.cardIssuer, equals(Issuers.VISA));

    var cat2 = new creditCat("4111111111111111");
    expect(cat2.cardIssuer, equals(Issuers.VISA));

    var cat3 = new creditCat("4012888888881881");
    expect(cat3.cardIssuer, equals(Issuers.VISA));

    var cat4 = new creditCat("4222222222222");
    expect(cat4.cardIssuer, equals(Issuers.VISA));
  });

  test("Should return the right issuer name for Mastercard", () {
    var cat1 = new creditCat("510000");
    expect(cat1.cardIssuer, equals(Issuers.MASTERCARD));

    var cat2 = new creditCat("5555555555554444");
    expect(cat2.cardIssuer, equals(Issuers.MASTERCARD));

    var cat3 = new creditCat("5105105105105100");
    expect(cat3.cardIssuer, equals(Issuers.MASTERCARD));
  });

  test("Should return the right issuer name for Discover", () {
    var cat1 = new creditCat("601100");
    expect(cat1.cardIssuer, equals(Issuers.DISCOVER));

    var cat2 = new creditCat("644000");
    expect(cat2.cardIssuer, equals(Issuers.DISCOVER));

    var cat3 = new creditCat("650000");
    expect(cat3.cardIssuer, equals(Issuers.DISCOVER));

    var cat4 = new creditCat("6011111111111117");
    expect(cat4.cardIssuer, equals(Issuers.DISCOVER));

    var cat5 = new creditCat("6011000990139424");
    expect(cat5.cardIssuer, equals(Issuers.DISCOVER));
  });

  test("Should return the right issuer for Amex", () {
    var cat1 = new creditCat("340000");
    expect(cat1.cardIssuer, equals(Issuers.AMEX));

    var cat2 = new creditCat("370000");
    expect(cat2.cardIssuer, equals(Issuers.AMEX));

    var cat3 = new creditCat("378282246310005");
    expect(cat3.cardIssuer, equals(Issuers.AMEX));

    var cat4 = new creditCat("371449635398431");
    expect(cat4.cardIssuer, equals(Issuers.AMEX));
  });

  test("Should return unknown for an issuer that hasn't been implemented yet", () {
    var cat1 = new creditCat("999999");
    expect(cat1.cardIssuer, equals(Issuers.UNKNOWN));
  });

  test("Should return JSON object", () {
    var cat = new creditCat("5232132174");
    expect(JSON.encode(cat), equals('{"number":"5232132174","industry":"Banking and Financial","issuer":"Mastercard","valid":true}'));
  });

  test("Should return String", () {
    var cat = new creditCat("5232132174");
    expect(cat.toString(), equals('number: 5232132174, industry: Banking and Financial, issuer: Mastercard, valid: true'));
  });

 }
