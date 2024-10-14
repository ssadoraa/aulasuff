DROP TABLE if exists devweb.produto;

CREATE TABLE devweb.produto (
   id INT NOT NULL AUTO_INCREMENT,
   nome VARCHAR(100) NOT NULL,
   descricao TEXT,
   categoria VARCHAR(50),
   condicao VARCHAR(20),
   imagens TEXT,
   valor_estimado DECIMAL(10,2),
   status VARCHAR(20),
   PRIMARY KEY (id)
)
ENGINE = INNODB
CHARACTER SET utf8mb4;

INSERT INTO devweb.produto (nome, descricao, categoria, condicao, imagens, valor_estimado, status)
VALUES ('iPhone 12', 'Apple iPhone 12 de 128GB na cor preta', 'Eletrônicos', 'Novo', 'https://exemplo.com/iphone12.jpg', 1200.00, 'Disponível'),
       ('Camiseta Nike', 'Camiseta Nike Dri-Fit tamanho M na cor azul', 'Roupas', 'Usado', 'https://exemplo.com/camiseta_nike.jpg', 25.00, 'Disponível');

