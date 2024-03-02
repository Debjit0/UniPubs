class Publication {
  Authors? authors;
  AuthorSID? authorSID;
  String? title;
  int? year;
  String? sourceTitle;
  Null? volume;
  Null? issue;
  String? pageStart;
  int? pageEnd;
  String? dOI;
  Affiliations? affiliations;
  Null? fundingDetails;
  Null? fundingText1;
  Null? fundingText2;
  Null? references;
  String? correspondenceAddress;
  Null? editors;
  Null? sponsors;
  String? publisher;
  Null? conferenceName;
  Null? conferenceDate;
  Null? conferenceLocation;
  Null? cODEN;
  Null? pubMedID;
  String? languageOfOriginalDocument;
  String? abbreviatedSourceTitle;
  String? documentType;
  String? publicationStage;
  Null? openAccess;
  String? source;
  String? eID;

  Publication(
      {this.authors,
      this.authorSID,
      this.title,
      this.year,
      this.sourceTitle,
      this.volume,
      this.issue,
      this.pageStart,
      this.pageEnd,
      this.dOI,
      this.affiliations,
      this.fundingDetails,
      this.fundingText1,
      this.fundingText2,
      this.references,
      this.correspondenceAddress,
      this.editors,
      this.sponsors,
      this.publisher,
      this.conferenceName,
      this.conferenceDate,
      this.conferenceLocation,
      this.cODEN,
      this.pubMedID,
      this.languageOfOriginalDocument,
      this.abbreviatedSourceTitle,
      this.documentType,
      this.publicationStage,
      this.openAccess,
      this.source,
      this.eID});

  Publication.fromJson(Map<String, dynamic> json) {
    authors =
        json['Authors'] != null ? new Authors.fromJson(json['Authors']) : null;
    authorSID = json['Author(s) ID'] != null
        ? new AuthorSID.fromJson(json['Author(s) ID'])
        : null;
    title = json['Title'];
    year = json['Year'];
    sourceTitle = json['Source title'];
    //volume = json['Volume']==null?"null":json["volume"];
    //issue = json['Issue']==null?"null":json['Issue'];
    //pageStart = json['Page start'];
    //pageEnd = json['Page end'];
    dOI = json['DOI'];
    affiliations = json['Affiliations'] != null
        ? new Affiliations.fromJson(json['Affiliations'])
        : null;
    //fundingDetails = json['Funding Details'];
    //fundingText1 = json['Funding Text 1'];
    //fundingText2 = json['Funding Text 2'];
    references = json['References'];
    //correspondenceAddress = json['Correspondence Address'];
    //editors = json['Editors'];
    //sponsors = json['Sponsors'];
    //publisher = json['Publisher'];
    //conferenceName = json['Conference name'];
    //conferenceDate = json['Conference date'];
    //conferenceLocation = json['Conference location'];
    //cODEN = json['CODEN'];
    //pubMedID = json['PubMed ID'];
    //languageOfOriginalDocument = json['Language of Original Document'];
    //abbreviatedSourceTitle = json['Abbreviated Source Title'];
    documentType = json['Document Type'];
    //publicationStage = json['Publication Stage'];
    //openAccess = json['Open Access'];
    //source = json['Source'];
    //eID = json['EID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.authors != null) {
      data['Authors'] = this.authors!.toJson();
    }
    if (this.authorSID != null) {
      data['Author(s) ID'] = this.authorSID!.toJson();
    }
    data['Title'] = this.title;
    data['Year'] = this.year;
    data['Source title'] = this.sourceTitle;
    data['Volume'] = this.volume;
    data['Issue'] = this.issue;
    data['Page start'] = this.pageStart;
    data['Page end'] = this.pageEnd;
    data['DOI'] = this.dOI;
    if (this.affiliations != null) {
      data['Affiliations'] = this.affiliations!.toJson();
    }
    data['Funding Details'] = this.fundingDetails;
    data['Funding Text 1'] = this.fundingText1;
    data['Funding Text 2'] = this.fundingText2;
    data['References'] = this.references;
    data['Correspondence Address'] = this.correspondenceAddress;
    data['Editors'] = this.editors;
    data['Sponsors'] = this.sponsors;
    data['Publisher'] = this.publisher;
    data['Conference name'] = this.conferenceName;
    data['Conference date'] = this.conferenceDate;
    data['Conference location'] = this.conferenceLocation;
    data['CODEN'] = this.cODEN;
    data['PubMed ID'] = this.pubMedID;
    data['Language of Original Document'] = this.languageOfOriginalDocument;
    data['Abbreviated Source Title'] = this.abbreviatedSourceTitle;
    data['Document Type'] = this.documentType;
    data['Publication Stage'] = this.publicationStage;
    data['Open Access'] = this.openAccess;
    data['Source'] = this.source;
    data['EID'] = this.eID;
    return data;
  }
}

class Authors {
  String? a1;
  String? a2;
  String? a3;
  String? a4;
  String? a5;
  String? a6;

  Authors({this.a1, this.a2, this.a3, this.a4, this.a5, this.a6});

  Authors.fromJson(Map<String, dynamic> json) {
    a1 = json['a1'];
    a2 = json['a2'];
    a3 = json['a3'];
    a4 = json['a4'];
    a5 = json['a5'];
    a6 = json['a6'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['a1'] = this.a1;
    data['a2'] = this.a2;
    data['a3'] = this.a3;
    data['a4'] = this.a4;
    data['a5'] = this.a5;
    data['a6'] = this.a6;
    return data;
  }
}

class AuthorSID {
  String? id1;
  String? id2;
  String? id3;
  String? id4;
  String? id5;
  String? id6;

  AuthorSID({this.id1, this.id2, this.id3, this.id4, this.id5, this.id6});

  AuthorSID.fromJson(Map<String, dynamic> json) {
    id1 = json['id1'];
    id2 = json['id2'];
    id3 = json['id3'];
    id4 = json['id4'];
    id5 = json['id5'];
    id6 = json['id6'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id1'] = this.id1;
    data['id2'] = this.id2;
    data['id3'] = this.id3;
    data['id4'] = this.id4;
    data['id5'] = this.id5;
    data['id6'] = this.id6;
    return data;
  }
}

class Affiliations {
  String? af1;
  String? af2;
  String? af3;
  String? af4;
  String? af5;
  String? af6;

  Affiliations({this.af1, this.af2});

  Affiliations.fromJson(Map<String, dynamic> json) {
    af1 = json['af1'];
    af2 = json['af2'];
    af3 = json['af3'];
    af4 = json['af4'];
    af5 = json['af5'];
    af6 = json['af6'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['af1'] = this.af1;
    data['af2'] = this.af2;
    data['af3'] = this.af3;
    data['af4'] = this.af4;
    data['af5'] = this.af5;
    data['af6'] = this.af6;
    return data;
  }
}