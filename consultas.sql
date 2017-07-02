SELECT SUM(quantidade) FROM cargo, regime WHERE cargo.idRegime = regime.idRegime;

SELECT municipio.nomeMunicipio, saude.encontrosCS
FROM saude
LEFT JOIN municipio ON saude.idMunicipio=municipio.idMunicipio;

SELECT municipio.nomeMunicipio, partido.sigla, estado.sigla FROM municipio, mandato, partido, estado
WHERE mandato.idMunicipio = municipio.idMunicipio and mandato.ano = "2008"
and mandato.idPartido = partido.idPartido and partido.sigla = "PT" and municipio.idEstado = estado.idEstado
UNION
SELECT municipio.nomeMunicipio, partido.sigla, estado.sigla FROM municipio, mandato, partido, estado
WHERE mandato.idMunicipio = municipio.idMunicipio and mandato.ano = "2012"
and mandato.idPartido = partido.idPartido and partido.sigla = "PT" and municipio.idEstado = estado.idEstado;

SELECT partido.sigla FROM partido WHERE partido.idPartido
IN (SELECT idPartido FROM mandato, municipio WHERE municipio.populacao > 500000 and mandato.idMunicipio = municipio.idMunicipio);

SELECT SUM(quantidade), partido.sigla, COUNT(municipio.nomeMunicipio), SUM(quantidade)/COUNT(municipio.nomeMunicipio)
FROM cargo, mandato, municipio, partido WHERE cargo.idMandato = mandato.idMandato and mandato.idMunicipio = municipio.idMunicipio and partido.idPartido = mandato.idPartido
GROUP BY partido.sigla;
