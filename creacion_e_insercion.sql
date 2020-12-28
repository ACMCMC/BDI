BEGIN;

CREATE TABLE mejor_amigo(anadidor VARCHAR(30), anadido VARCHAR(30), FOREIGN KEY (anadidor) REFERENCES usuario(nickname) ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY (anadido) REFERENCES usuario(nickname) ON DELETE CASCADE ON UPDATE CASCADE, PRIMARY KEY (anadidor, anadido));

INSERT INTO mejor_amigo(anadidor, anadido) VALUES ('aldancm', 'hugogs');
INSERT INTO mejor_amigo(anadidor, anadido) VALUES ('aldancm', 'roquefi');
INSERT INTO mejor_amigo(anadidor, anadido) VALUES ('aldancm', 'diegofp');
INSERT INTO mejor_amigo(anadidor, anadido) VALUES ('aldancm', 'ivandf');
INSERT INTO mejor_amigo(anadidor, anadido) VALUES ('ivandf', 'aldancm');
INSERT INTO mejor_amigo(anadidor, anadido) VALUES ('ivandf', 'hugogs');
INSERT INTO mejor_amigo(anadidor, anadido) VALUES ('ivandf', 'diegofp');
INSERT INTO mejor_amigo(anadidor, anadido) VALUES ('hugogs', 'aldancm');
INSERT INTO mejor_amigo(anadidor, anadido) VALUES ('hugogs', 'elenafd');
INSERT INTO mejor_amigo(anadidor, anadido) VALUES ('elenafd', 'hugogs');

COMMIT;