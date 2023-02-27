class Model {
  final String universidade;
  final String regiao;
  final String cidade;
  final String adm;
  final String a;
  final String aa;
  final String aaa;

  Model(
    this.universidade,
    this.regiao,
    this.cidade,
    this.adm,
    this.a,
    this.aa,
    this.aaa,
  );

  Map<String, String> toJson() {
    return {
      'university': universidade,
      'region': regiao,
      'city': cidade,
      'lcGV': a,
      'lcGtaShort': aa,
      'lcGtaMl': aa,
      'lcGte': aaa,
    };
  }
}
