-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 05-Jul-2021 às 01:27
-- Versão do servidor: 10.4.14-MariaDB
-- versão do PHP: 7.2.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `loja_virtual`
--
CREATE DATABASE IF NOT EXISTS `loja_virtual` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `loja_virtual`;

-- --------------------------------------------------------

--
-- Estrutura da tabela `categoria`
--

DROP TABLE IF EXISTS `categoria`;
CREATE TABLE IF NOT EXISTS `categoria` (
  `id` int(11) NOT NULL,
  `descricao` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `categoria`
--

INSERT INTO `categoria` (`id`, `descricao`) VALUES
(1, 'Eletrodomestico'),
(2, 'Eletroportateis'),
(3, 'Celulares'),
(4, 'Motos'),
(5, 'Carros');

-- --------------------------------------------------------

--
-- Estrutura da tabela `cliente`
--

DROP TABLE IF EXISTS `cliente`;
CREATE TABLE IF NOT EXISTS `cliente` (
  `id_cliente` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `dt_nascimento` date DEFAULT NULL,
  `nome_mae` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_cliente`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `cliente`
--

INSERT INTO `cliente` (`id_cliente`, `username`, `email`, `dt_nascimento`, `nome_mae`) VALUES
(1, 'diogenes-dh', 'diogenes@digitalhouse.com', '1987-07-14', 'Maria Jose'),
(2, 'diogo-dh', 'diogo@digitalhouse.com', '1991-06-21', NULL),
(3, 'lucas-dh', 'lucas-santos@digitalhouse.com', '1989-09-12', 'Maria');

-- --------------------------------------------------------

--
-- Estrutura da tabela `cliente_cupom`
--

DROP TABLE IF EXISTS `cliente_cupom`;
CREATE TABLE IF NOT EXISTS `cliente_cupom` (
  `id_cliente` int(11) NOT NULL,
  `id_cupom` int(11) NOT NULL,
  PRIMARY KEY (`id_cliente`,`id_cupom`),
  KEY `id_cupom_cliente` (`id_cupom`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `conta`
--

DROP TABLE IF EXISTS `conta`;
CREATE TABLE IF NOT EXISTS `conta` (
  `id_conta` int(11) NOT NULL AUTO_INCREMENT,
  `agencia` int(11) NOT NULL,
  `banco` int(11) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  PRIMARY KEY (`id_conta`),
  KEY `fk_id_cliente` (`id_cliente`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `conta`
--

INSERT INTO `conta` (`id_conta`, `agencia`, `banco`, `id_cliente`) VALUES
(1, 1240, 341, 3),
(2, 2511, 237, 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `cupom`
--

DROP TABLE IF EXISTS `cupom`;
CREATE TABLE IF NOT EXISTS `cupom` (
  `id_cupom` int(11) NOT NULL AUTO_INCREMENT,
  `serial` varchar(255) NOT NULL,
  `valor` decimal(10,0) NOT NULL,
  `expiracao` date NOT NULL,
  PRIMARY KEY (`id_cupom`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `endereco`
--

DROP TABLE IF EXISTS `endereco`;
CREATE TABLE IF NOT EXISTS `endereco` (
  `id_endereco` int(11) NOT NULL AUTO_INCREMENT,
  `numero` int(11) NOT NULL,
  `estado` varchar(50) NOT NULL,
  `logradouro` varchar(255) NOT NULL,
  `cep` int(11) NOT NULL,
  `fk_id_cliente_endereco` int(11) NOT NULL,
  PRIMARY KEY (`id_endereco`),
  KEY `fk_id_cliente_endereco` (`fk_id_cliente_endereco`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `estoque`
--

DROP TABLE IF EXISTS `estoque`;
CREATE TABLE IF NOT EXISTS `estoque` (
  `codigo` int(11) NOT NULL,
  `id_produto` int(11) NOT NULL,
  `quantidade` int(11) NOT NULL,
  PRIMARY KEY (`codigo`),
  KEY `fk_id_produto` (`id_produto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `estoque`
--

INSERT INTO `estoque` (`codigo`, `id_produto`, `quantidade`) VALUES
(1, 6, 1),
(2, 7, 5),
(3, 8, 1),
(4, 4, 3),
(5, 3, 7),
(6, 5, 10),
(7, 1, 5);

-- --------------------------------------------------------

--
-- Estrutura da tabela `pedido`
--

DROP TABLE IF EXISTS `pedido`;
CREATE TABLE IF NOT EXISTS `pedido` (
  `id_pedido` int(11) NOT NULL AUTO_INCREMENT,
  `nota_fiscal` varchar(255) NOT NULL,
  `data_solicitacao` datetime NOT NULL,
  `valor_total` decimal(10,2) NOT NULL,
  `status` varchar(20) NOT NULL,
  `fk_id_cliente_pedido` int(11) NOT NULL,
  PRIMARY KEY (`id_pedido`),
  KEY `fk_id_cliente_pedido` (`fk_id_cliente_pedido`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `pedido`
--

INSERT INTO `pedido` (`id_pedido`, `nota_fiscal`, `data_solicitacao`, `valor_total`, `status`, `fk_id_cliente_pedido`) VALUES
(1, '200004422', '2021-06-29 19:53:31', '2620.00', 'CONCLUIDO', 1),
(2, '200004423', '2021-06-30 17:53:31', '1240.00', 'CONCLUIDO', 2),
(4, '200004424', '2021-06-30 19:53:31', '1470.00', 'CONCLUIDO', 3),
(5, '245100021', '2021-06-23 21:25:17', '1000.00', 'FATURAMENTO', 2);

-- --------------------------------------------------------

--
-- Estrutura da tabela `pedido_produto`
--

DROP TABLE IF EXISTS `pedido_produto`;
CREATE TABLE IF NOT EXISTS `pedido_produto` (
  `id_pedido` int(11) NOT NULL,
  `id_produto` int(11) NOT NULL,
  `quantidade_produto` int(11) NOT NULL,
  PRIMARY KEY (`id_pedido`,`id_produto`),
  KEY `fk_produto_pedido` (`id_produto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `pedido_produto`
--

INSERT INTO `pedido_produto` (`id_pedido`, `id_produto`, `quantidade_produto`) VALUES
(1, 1, 1),
(1, 3, 1),
(2, 5, 2),
(5, 3, 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `produto`
--

DROP TABLE IF EXISTS `produto`;
CREATE TABLE IF NOT EXISTS `produto` (
  `id_produto` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(255) NOT NULL,
  `nome` varchar(255) NOT NULL,
  `descricao` longtext NOT NULL,
  `preco` decimal(10,2) NOT NULL,
  `id_categoria` int(11) NOT NULL,
  PRIMARY KEY (`id_produto`),
  KEY `IDX_nome` (`nome`),
  KEY `fk_id_categoria` (`id_categoria`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `produto`
--

INSERT INTO `produto` (`id_produto`, `codigo`, `nome`, `descricao`, `preco`, `id_categoria`) VALUES
(1, '45', 'Geladeira Electrolux ', 'Geladeira 45L Inox', '1680.00', 1),
(3, '7812', 'Fogão 5 Bocas Arno', 'Arno 5Bocas com Acendimento Automatico Fast Clean', '1450.00', 1),
(4, '2540', 'Geladeira Brastemp', 'Brastemp Inox 45L', '2420.00', 1),
(5, '2550', 'Geladeira Consul', 'Consul Inox 45L com Degelo', '2310.00', 1),
(6, '5454021', 'Mustang Shelby', 'Mustang Shelby Cobra 1968 Vermelho', '400000.00', 5),
(7, '2541', 'Geladeira Brastemp', 'Geladeira Brastemp Branca 45L', '1800.00', 1),
(8, '87126', 'Liquidificador Oster ', 'Liquidificador do Felip de Copo Vidro Vermelho', '387.49', 2);

-- --------------------------------------------------------

--
-- Estrutura da tabela `telefone`
--

DROP TABLE IF EXISTS `telefone`;
CREATE TABLE IF NOT EXISTS `telefone` (
  `id_telefone` int(11) NOT NULL AUTO_INCREMENT,
  `ddd` int(11) NOT NULL,
  `telefone` int(11) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  PRIMARY KEY (`id_telefone`),
  KEY `fk_id_cliente_idx` (`id_cliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE IF NOT EXISTS `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `data_admissao` date NOT NULL,
  `salario` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `nome`, `data_admissao`, `salario`) VALUES
(1, 'Emílio Fenandes', '2010-09-01', '3500.00'),
(2, 'Francisco Gomes', '2009-07-11', '4800.00'),
(3, 'Daniel Estrada', '2010-09-01', '3500.00'),
(4, 'Célio Drummond', '2009-07-11', '6145.00'),
(5, 'Abelardo Barbosa', '2010-09-01', '2100.00'),
(6, 'Bernardo Costa', '2011-05-05', '5575.00');

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `cliente_cupom`
--
ALTER TABLE `cliente_cupom`
  ADD CONSTRAINT `id_cliente_cupom` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`),
  ADD CONSTRAINT `id_cupom_cliente` FOREIGN KEY (`id_cupom`) REFERENCES `cupom` (`id_cupom`);

--
-- Limitadores para a tabela `conta`
--
ALTER TABLE `conta`
  ADD CONSTRAINT `fk_id_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`) ON UPDATE CASCADE;

--
-- Limitadores para a tabela `endereco`
--
ALTER TABLE `endereco`
  ADD CONSTRAINT `fk_id_cliente_endereco` FOREIGN KEY (`fk_id_cliente_endereco`) REFERENCES `cliente` (`id_cliente`);

--
-- Limitadores para a tabela `estoque`
--
ALTER TABLE `estoque`
  ADD CONSTRAINT `fk_id_produto` FOREIGN KEY (`id_produto`) REFERENCES `produto` (`id_produto`);

--
-- Limitadores para a tabela `pedido`
--
ALTER TABLE `pedido`
  ADD CONSTRAINT `fk_id_cliente_pedido` FOREIGN KEY (`fk_id_cliente_pedido`) REFERENCES `cliente` (`id_cliente`);

--
-- Limitadores para a tabela `pedido_produto`
--
ALTER TABLE `pedido_produto`
  ADD CONSTRAINT `fk_pedido_produto` FOREIGN KEY (`id_pedido`) REFERENCES `pedido` (`id_pedido`),
  ADD CONSTRAINT `fk_produto_pedido` FOREIGN KEY (`id_produto`) REFERENCES `produto` (`id_produto`);

--
-- Limitadores para a tabela `produto`
--
ALTER TABLE `produto`
  ADD CONSTRAINT `fk_id_categoria` FOREIGN KEY (`id_categoria`) REFERENCES `categoria` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `telefone`
--
ALTER TABLE `telefone`
  ADD CONSTRAINT `fk_id_cliente_telefone` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
