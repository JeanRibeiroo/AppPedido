CREATE DATABASE  IF NOT EXISTS `apppedido` /*!40100 DEFAULT CHARACTER SET utf8 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `apppedido`;
-- MySQL dump 10.13  Distrib 8.0.26, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: apppedido
-- ------------------------------------------------------
-- Server version	8.0.26

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `Codigo` int NOT NULL AUTO_INCREMENT,
  `Nome` varchar(45) DEFAULT NULL,
  `CIdade` varchar(45) DEFAULT NULL,
  `UF` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`Codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (1,'Marcos da Silva','Blumenau','SC'),(2,'Maria Eduarda','Blumenau','SC'),(3,'Alexandre de Oliveira','Blumenau','SC'),(4,'Elemar dos Santos','Blumenau','SC'),(5,'Indionei Passos','Jaragua do Sul','SC'),(6,'Ricardo Silva','Balneario Camboriu','SC'),(7,'Graze Debatin','Blumenau','SC'),(8,'Daniel Zibel','Indaial','SC'),(9,'Juliano da Silva','Indaial','SC'),(10,'Toni de Paula','Florianopolis','SC'),(11,'Yara Gonsalves','Rodeio','SC'),(12,'Alcides Passos','Rodeio','SC'),(13,'Jean Ribeiro','Blumenau','SC'),(14,'Tiado Souza','Navegantes','SC'),(15,'Tainara Bittencurt','Tubarão','SC'),(16,'Juliana Mello','Blumenau','SC'),(17,'Sergio Oliveira','Lages','SC'),(18,'Miriam Rocha','Camboriu','SC'),(19,'Donizete Machado','Gaspar','SC'),(20,'Rafael Ribeiro','Ibirama','SC');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedido`
--

DROP TABLE IF EXISTS `pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedido` (
  `NumeroPedido` int unsigned NOT NULL,
  `DataEmissao` date DEFAULT NULL,
  `ValorTotal` double DEFAULT NULL,
  `CodigoCliente` int NOT NULL,
  UNIQUE KEY `NumeroPedido_UNIQUE` (`NumeroPedido`),
  KEY `fk_Pedido_Cliente_idx` (`CodigoCliente`),
  CONSTRAINT `fk_Pedido_Cliente` FOREIGN KEY (`CodigoCliente`) REFERENCES `cliente` (`Codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedido`
--

LOCK TABLES `pedido` WRITE;
/*!40000 ALTER TABLE `pedido` DISABLE KEYS */;
INSERT INTO `pedido` VALUES (1,'2022-03-10',0,1),(2,'2022-03-11',106.2,5),(3,'2022-03-11',47.3,12),(4,'2022-03-11',27.5,20),(5,'2022-03-11',24.6,7),(6,'2022-03-11',280,2),(7,'2022-03-14',123.8,5),(8,'2022-03-14',12,1);
/*!40000 ALTER TABLE `pedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidoproduto`
--

DROP TABLE IF EXISTS `pedidoproduto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidoproduto` (
  `idPedidoProduto` int NOT NULL AUTO_INCREMENT,
  `Quantidade` int DEFAULT NULL,
  `ValorUnitario` double DEFAULT NULL,
  `ValorTotal` double DEFAULT NULL,
  `CodigoProduto` int NOT NULL,
  `NumeroPedido` int NOT NULL,
  PRIMARY KEY (`idPedidoProduto`),
  KEY `fk_PedidoProduto_Produto1_idx` (`CodigoProduto`),
  CONSTRAINT `fk_PedidoProduto_Produto1` FOREIGN KEY (`CodigoProduto`) REFERENCES `produto` (`Codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=5622 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidoproduto`
--

LOCK TABLES `pedidoproduto` WRITE;
/*!40000 ALTER TABLE `pedidoproduto` DISABLE KEYS */;
INSERT INTO `pedidoproduto` VALUES (3,2,15,30,2,1),(5606,2,12,24,1,2),(5607,2,23,46,6,2),(5608,3,36.2,36.2,18,2),(5609,1,6.4,6.4,14,3),(5611,1,16.3,16.3,20,3),(5612,5,2.3,11.5,1,4),(5613,7,3.2,16,2,4),(5614,4,12.3,36.9,2,5),(5615,5,56,280,5,6),(5616,4,4.5,18,2,7),(5617,6,5.3,31.8,5,7),(5618,1,3.2,3.2,20,7),(5619,1,7.8,7.8,10,7),(5620,10,6.3,63,16,7),(5621,1,12,12,5,8);
/*!40000 ALTER TABLE `pedidoproduto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produto`
--

DROP TABLE IF EXISTS `produto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produto` (
  `Codigo` int NOT NULL AUTO_INCREMENT,
  `Descricao` varchar(45) DEFAULT NULL,
  `PrecoVendas` double DEFAULT NULL,
  PRIMARY KEY (`Codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produto`
--

LOCK TABLES `produto` WRITE;
/*!40000 ALTER TABLE `produto` DISABLE KEYS */;
INSERT INTO `produto` VALUES (1,'Lapis ',2.1),(2,'Caneta Bic',3.15),(3,'Borracha',0.8),(4,'Canetinha 6 cores',15.6),(5,'Caderno',5.4),(6,'Caderno 10 Materias',34.7),(7,'Caderno de Desenho',12.1),(8,'Bloco de Notas',8.2),(9,'Regua 30 cm',4.6),(10,'Compasso',6.8),(11,'Livro Infantil',60.4),(12,'Caderno de Calegrafia',3.4),(13,'Pasta Brasil',2.8),(14,'Tesoura',5.4),(15,'Guache Tinta',13.7),(16,'Tinta Oleo',24.5),(17,'Giz de Cera',25.6),(18,'Canetinha jogo 20',36.2),(19,'Dicionario',18.3),(20,'Apontador',6.8);
/*!40000 ALTER TABLE `produto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teste`
--

DROP TABLE IF EXISTS `teste`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teste` (
  `idteste` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`idteste`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teste`
--

LOCK TABLES `teste` WRITE;
/*!40000 ALTER TABLE `teste` DISABLE KEYS */;
/*!40000 ALTER TABLE `teste` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'apppedido'
--

--
-- Dumping routines for database 'apppedido'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-03-14 12:00:46
