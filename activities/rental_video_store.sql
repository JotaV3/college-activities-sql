DROP DATABASE IF EXISTS RentalVideoStore;
CREATE DATABASE RentalVideoStore;
USE RentalVideoStore;

CREATE TABLE state(
	id INT PRIMARY KEY,
    state_name VARCHAR(50) NOT NULL,
    acronym CHAR(2) NOT NULL
);

CREATE TABLE city(
	id INT PRIMARY KEY,
    state_id INT,
    
    city_name VARCHAR(50) NOT NULL,
    
    FOREIGN KEY(state_id) REFERENCES state(id)
);

CREATE TABLE person(
	id INT PRIMARY KEY,
    city_id INT,
    
    person_name VARCHAR(50) NOT NULL,
    address VARCHAR(100) NOT NULL,
    address_number INT(20) NOT NULL,
    complement VARCHAR(50),
    neighborhood VARCHAR(50) NOT NULL,
    phone VARBINARY(20) NOT NULL,
    sex CHAR(1) NOT NULL,
    
    FOREIGN KEY(city_id) REFERENCES city(id)
);

CREATE TABLE customer(
	id INT PRIMARY KEY,
    person_id INT,
    
    registration_date DATE NOT NULL,
    
    FOREIGN KEY(person_id) REFERENCES person(id)
);

CREATE TABLE employee(
	id INT AUTO_INCREMENT PRIMARY KEY,
    person_id INT,
    
    hiring_date DATE NOT NULL,
    termination_date DATE,
    salary DECIMAL(10,2) NOT NULL,
    position VARCHAR(50),
    
    FOREIGN KEY(person_id) REFERENCES person(id)
);

CREATE TABLE loan(
	id INT PRIMARY KEY,
    customer_id INT,
    
    loan_date DATE NOT NULL,
    penalty_total DECIMAL(10,2) NOT NULL DEFAULT 0,
    
    FOREIGN KEY(customer_id) REFERENCES customer(id)
);

CREATE TABLE film(
	id INT PRIMARY KEY,
    
    title VARCHAR(50) NOT NULL,
    duration INT NOT NULL,
    director VARCHAR(50) NOT NULL,
    actors TEXT NOT NULL,
    synopsis TEXT NOT NULL
);

CREATE TABLE gender(
	id INT PRIMARY KEY,
    
    gender_description TEXT NOT NULL
);

CREATE TABLE film_gender(
	film_id INT,
    gender_id INT,

	PRIMARY KEY(film_id, gender_id),
    FOREIGN KEY(film_id) REFERENCES film(id),
    FOREIGN KEY(gender_id) REFERENCES gender(id)
);

CREATE TABLE media_type(
	id INT PRIMARY KEY,
    
	media_type_description VARCHAR(50) NOT NULL
);

CREATE TABLE media(
	id INT PRIMARY KEY,
    film_id INT,
    media_type_id INT,
    
    acquisition_date DATE NOT NULL,
    
    FOREIGN KEY(film_id) REFERENCES film(id),
    FOREIGN KEY(media_type_id) REFERENCES media_type(id)
);

CREATE TABLE loan_item(
	id INT PRIMARY KEY,
    loan_id INT,
    media_id INT,
    
    expected_return_date DATE NOT NULL,
    return_date DATE,
    
    FOREIGN KEY(loan_id) REFERENCES loan(id),
    FOREIGN KEY(media_id) REFERENCES media(id)
);

INSERT INTO state VALUES
(1,'Minas Gerais','MG'),(2,'São Paulo','SP'),(3,'Rio de Janeiro','RJ');

INSERT INTO city VALUES
(1,1,'Belo Horizonte'),(2,2,'São Paulo'),(3,3,'Rio de Janeiro');

INSERT INTO person VALUES
(1,1,'João Silva','Rua A','100',NULL,'Centro','319999999','M'),
(2,1,'Maria Souza','Rua B','200','Ap 10','Savassi','319888888','F'),
(3,2,'Carlos Pereira','Av Paulista','1500',NULL,'Paulista','119777777','M'),
(4,2,'Ana Lima','Rua das Flores','300',NULL,'Moema','119666666','F'),
(5,3,'Pedro Santos','Rua Atlântica','400',NULL,'Copacabana','219555555','M'),
(6,3,'Juliana Alves','Rua das Laranjeiras','500','Casa','Laranjeiras','219444444','F'),
(7,1,'Lucas Mendes','Rua Goiás','600',NULL,'Funcionários','319333333','M'),
(8,2,'Fernanda Costa','Rua Augusta','700',NULL,'Consolação','119222222','F'),
(9,3,'Ricardo Rocha','Rua Voluntários','800',NULL,'Botafogo','219111111','M'),
(10,1,'Patrícia Gomes','Rua Paraná','900',NULL,'Centro','319000000','F');

INSERT INTO customer VALUES
(1,1,'2025-01-10'),
(2,2,'2025-02-15'),
(3,4,'2025-03-01'),
(4,5,'2025-03-05'),
(5,6,'2025-03-07');

INSERT INTO employee VALUES
(1,3,'2024-05-01',NULL,3500,'Atendente'),
(2,7,'2024-06-10',NULL,4000,'Gerente'),
(3,8,'2024-07-20',NULL,2800,'Caixa');

INSERT INTO media_type VALUES
(1,'DVD'),(2,'Blu-ray'),(3,'Streaming');

INSERT INTO film VALUES
(1,'Matrix',136,'Wachowski','Keanu Reeves, Laurence Fishburne','Um hacker descobre a
verdade sobre sua realidade.'),
(2,'Titanic',195,'James Cameron','Leonardo DiCaprio, Kate Winslet','Romance épico no
navio Titanic.'),
(3,'Avatar',162,'James Cameron','Sam Worthington, Zoe Saldana','Uma aventura em
Pandora.'),
(4,'Gladiador',155,'Ridley Scott','Russell Crowe, Joaquin Phoenix','Um general romano
busca vingança.'),
(5,'O Senhor dos Anéis',178,'Peter Jackson','Elijah Wood, Ian McKellen','A jornada para
destruir o anel.'),
(6,'Harry Potter',152,'Chris Columbus','Daniel Radcliffe, Emma Watson','Um jovem
descobre ser bruxo.'),
(7,'Jurassic Park',127,'Steven Spielberg','Sam Neill, Laura Dern','Dinossauros voltam à
vida.'),
(8,'Star Wars',121,'George Lucas','Mark Hamill, Harrison Ford','A luta contra o Império.'),
(9,'Homem-Aranha',133,'Sam Raimi','Tobey Maguire, Kirsten Dunst','Um jovem ganha
poderes de aranha.'),
(10,'Batman Begins',140,'Christopher Nolan','Christian Bale, Michael Caine','A origem do
Cavaleiro das Trevas.');

INSERT INTO media VALUES
(1,1,1,'2025-01-01'),
(2,2,2,'2025-01-05'),
(3,3,3,'2025-01-10'),
(4,4,1,'2025-01-15'),
(5,5,2,'2025-01-20'),
(6,6,3,'2025-01-25'),
(7,7,1,'2025-02-01'),
(8,8,2,'2025-02-05'),
(9,9,3,'2025-02-10'),
(10,10,1,'2025-02-15');

INSERT INTO loan(id, customer_id, loan_date) VALUES
(1,1,'2025-03-01'),
(2,2,'2025-03-02'),
(3,3,'2025-03-03'),
(4,4,'2025-03-04'),
(5,5,'2025-03-05');

INSERT INTO loan_item VALUES
(1,1,1,'2025-03-10',NULL),
(2,2,2,'2025-03-12','2025-03-11'),
(3,3,3,'2025-03-15',NULL),
(4,4,4,'2025-03-16','2025-03-15'),
(5,5,5,'2025-03-17',NULL),
(6,1,6,'2025-03-18',NULL),
(7,2,7,'2025-03-19','2025-03-18'),
(8,3,8,'2025-03-20',NULL),
(9,4,9,'2025-03-21',NULL),
(10,5,10,'2025-03-22','2025-03-21');

INSERT INTO gender VALUES
(1,'Ação'),
(2,'Romance'),
(3,'Ficção Científica'),
(4,'Fantasia'),
(5,'Aventura');

INSERT INTO film_gender VALUES
(1,1), -- Matrix -> Ação
(1,3), -- Matrix -> Ficção Científica
(2,2), -- Titanic -> Romance
(3,3), -- Avatar -> Ficção Científica
(3,5), -- Avatar -> Aventura
(4,1), -- Gladiador -> Ação
(5,5), -- Senhor dos Anéis -> Aventura
(5,4), -- Senhor dos Anéis -> Fantasia
(6,4), -- Harry Potter -> Fantasia
(7,5); -- Jurassic Park -> Aventura

/* INDEX
Atividade 1 — Índice por cidade dos funcionários
• Contexto: relatórios de funcionários por cidade são lentos.
• Passos:
1. Identifique a tabela Pessoas (campo CidadeID).
2. Crie um índice para acelerar buscas por cidade.
3. Teste com uma consulta filtrando por cidade.
*/

CREATE INDEX idx_person_city_id
ON person(city_id);

SELECT e.id, p.person_name, p.city_id
FROM employee e
INNER JOIN person p ON p.id = e.person_id
WHERE city_id = 2;

/* INDEX
Atividade 2 — Índice por data de aquisição das mídias
• Contexto: relatórios de mídias adquiridas por período.
• Passos:
1. Use a tabela Midias.
2. Crie índice sobre DataAquisicao.
3. Teste com SELECT * FROM Midias WHERE DataAquisicao BETWEEN
*/

CREATE INDEX idx_media_acquisition_date
ON media(acquisition_date);

SELECT *
FROM media
WHERE acquisition_date BETWEEN '2025-01-10' AND '2025-01-31'; 

/* VIEW
Atividade 3 — View de filmes adquiridos por ano
• Contexto: relatório anual de novos filmes.
• Passos:
1. Relacione Filmes, Midias e TiposMidias.
2. Mostre Titulo, DataAquisicao, TipoMidia.
3. Agrupe ou ordene por ano de aquisição.
*/

CREATE VIEW vw_films_acquired_per_year AS
SELECT 
	f.title, 
    mt.media_type_description,
    m.acquisition_date
FROM film f
JOIN media m ON m.film_id = f.id
JOIN media_type mt ON mt.id = m.media_type_id;

SELECT *
FROM vw_films_acquired_per_year
ORDER BY YEAR(acquisition_date);

/* VIEW
Atividade 4 — View de clientes e total de empréstimos
• Contexto: controle de frequência de locações.
• Passos:
1. Relacione Clientes, Emprestimos e Pessoas.
2. Conte quantos empréstimos cada cliente fez.
3. Exiba Nome, DataCadastro, QtdEmprestimos.
*/

CREATE VIEW vw_customer_total_loan AS
SELECT 
	p.person_name,
    c.registration_date,
    COUNT(l.id) AS loan_amount
FROM customer c
INNER JOIN person p ON p.id = c.person_id
LEFT JOIN loan l ON l.customer_id = c.id
GROUP BY c.id, p.person_name, c.registration_date;

SELECT *
FROM vw_customer_total_loan;

/* PROCEDURE
Atividade 5 — Procedure para registrar novo funcionário
• Contexto: automatizar cadastro com data de admissão atual.
• Passos:
1. Use tabela Funcionarios.
2. Receba PessoaID e Salario como parâmetros.
3. Insira registro com DataAdmissao = CURDATE().
*/

DELIMITER //
CREATE PROCEDURE register_employee(
	IN p_personId INT,
    IN p_salary DECIMAL(10,2)
)
BEGIN
	INSERT INTO employee(person_id, hiring_date,salary)
    VALUES(p_personId, CURDATE(), p_salary);
END //

DELIMITER ;

CALL register_employee(9, 3200.50);

/* PROCEDURE
Atividade 6 — Procedure para aplicar multa de atraso
• Contexto: atualizar valor total do empréstimo com multa.
• Passos:
1. Use ItensEmprestimo e Emprestimos.
2. Calcule dias de atraso e valor da multa.
3. Atualize o total do empréstimo.
*/

DELIMITER //

CREATE PROCEDURE apply_late_penalty(
    IN p_loan_id INT,
    IN p_daily_penalty DECIMAL(10,2)
)
BEGIN
    DECLARE v_penalty_total DECIMAL(10,2);

    SELECT COALESCE(
        SUM(
            GREATEST(
                DATEDIFF(
                    COALESCE(return_date, CURDATE()),
                    expected_return_date
                ),
                0
            ) * p_daily_penalty
        ),
        0
    )
    INTO v_penalty_total
    FROM loan_item
    WHERE loan_id = p_loan_id;

    UPDATE loan
    SET penalty_total = v_penalty_total
    WHERE id = p_loan_id;

END //

DELIMITER ;

CALL apply_late_penalty(1, 2.00);

/* FUNCTION
Atividade 7 — Function para calcular tempo de casa do funcionário
• Contexto: calcular anos desde a admissão.
• Passos:
1. Use DataAdmissao da tabela Funcionarios.
2. Retorne diferença em anos até CURDATE().
*/

DELIMITER //

CREATE FUNCTION calculator_employee_length_service(
	p_employeeId INT
) 
RETURNS INT
NOT DETERMINISTIC
READS SQL DATA
BEGIN
	DECLARE v_hiring_date DATE;

	SELECT hiring_date
    INTO v_hiring_date
    FROM employee
    WHERE id = p_employeeId;
    
    RETURN TIMESTAMPDIFF(YEAR, v_hiring_date, CURDATE());
END //

SELECT calculator_employee_length_service(1);

/* FUNCTION
Atividade 8 — Function para verificar disponibilidade de mídia
• Contexto: impedir locação de mídia sem devolução.
• Passos:
1. Verifique se há registro em ItensEmprestimo sem DataDevolucao.
2. Retorne 1 (disponível) ou 0 (indisponível).
*/

DELIMITER //

CREATE FUNCTION is_media_available(
	p_mediaId INT
) 
RETURNS BOOLEAN
NOT DETERMINISTIC
READS SQL DATA
BEGIN
	DECLARE v_open_loans INT DEFAULT 0;

    SELECT COUNT(*)
    INTO v_open_loans
    FROM loan_item
    WHERE media_id = p_mediaId
    AND return_date IS NULL;

    RETURN v_open_loans = 0;
END //

DELIMITER ;

SELECT is_media_available(1);