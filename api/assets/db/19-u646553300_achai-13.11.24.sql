-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Tempo de geração: 14-Nov-2024 às 09:17
-- Versão do servidor: 10.11.10-MariaDB
-- versão do PHP: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `u646553300_achai`
--

DELIMITER $$
--
-- Procedimentos
--
CREATE DEFINER=`u646553300_achai`@`127.0.0.1` PROCEDURE `sp_register_listvalidationcodes` (`code_p` INT, `thing_id_p` INT)  BEGIN    
    
    DECLARE track_no VARCHAR(10) DEFAULT '0/0';
    DECLARE EXIT HANDLER FOR SQLEXCEPTION, NOT FOUND, SQLWARNING
    
    BEGIN    
        GET DIAGNOSTICS CONDITION 1 @`errno` = MYSQL_ERRNO, @`sqlstate` = RETURNED_SQLSTATE, @`text` = MESSAGE_TEXT;
        SET @full_error = CONCAT('ERROR ', @`errno`, ' (', @`sqlstate`, '): ', @`text`);
        SELECT track_no, @full_error;

        ROLLBACK;    
    END;

    START TRANSACTION;
        SET track_no = '1/2';
        INSERT INTO listvalidationcodes (code, thing_id) values(code_p, thing_id_p);

        SET track_no = '2/2'; 
        DELETE FROM listvalidationcodes WHERE (TIME_TO_SEC(NOW())) - (create_at) >= 300 OR (TIME_TO_SEC(NOW())) - (create_at)  < 0;        
                
        SET track_no = '0/2';
        SET @full_error = 'successfully executed.';
        SELECT track_no, @full_error;
    COMMIT;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `admins`
--

CREATE TABLE `admins` (
  `id` int(11) NOT NULL,
  `user` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `email` varchar(320) DEFAULT NULL,
  `hash` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `admins`
--

INSERT INTO `admins` (`id`, `user`, `password`, `email`, `hash`) VALUES
(7, 'root', '202cb962ac59075b964b07152d234b70', 'root', 'A0E812B01BFC8E2417C254A074DF599D');

-- --------------------------------------------------------

--
-- Estrutura da tabela `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `icon_name` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `categories`
--

INSERT INTO `categories` (`id`, `name`, `icon_name`) VALUES
(87, 'Ver todos', 'none'),
(88, 'Eletrônicos', 'headphones_FILL0_wght300_GRAD0_opsz40.svg'),
(89, 'Garrafas', 'water_bottle_FILL0_wght300_GRAD0_opsz40.svg'),
(90, 'Guarda-chuvas', 'umbrella_FILL0_wght300_GRAD0_opsz40.svg'),
(91, 'Todas', 'list_FILL0_wght300_GRAD0_opsz40.svg'),
(102, 'Papelaria', 'none'),
(103, 'Vestíveis', 'none'),
(104, 'Outros', 'none');

-- --------------------------------------------------------

--
-- Estrutura da tabela `emaillist`
--

CREATE TABLE `emaillist` (
  `id` int(11) NOT NULL,
  `addr` varchar(100) NOT NULL,
  `reserve_quantity` int(11) DEFAULT 1,
  `status` tinyint(4) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `emaillist`
--

INSERT INTO `emaillist` (`id`, `addr`, `reserve_quantity`, `status`) VALUES
(2, 'weversonmnzs@gmail.com', 1, 1),
(3, 'guilhermefn00@gmail.com', 1, 1),
(4, 'monalisamenezes@gmail.com', 1, 1),
(5, 'douglas2570@gmail.com', 1, 1),
(6, 'guilhermefnpro@gmail.com', 2, NULL),
(7, 'gabrielmachadosilva@gmail.com', 1, 1),
(8, 'tainalms05@gmail.com', 1, 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `listvalidationcodes`
--

CREATE TABLE `listvalidationcodes` (
  `id` int(11) NOT NULL,
  `code` int(4) NOT NULL,
  `create_at` int(11) DEFAULT time_to_sec(current_timestamp()),
  `thing_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `listvalidationcodes`
--

INSERT INTO `listvalidationcodes` (`id`, `code`, `create_at`, `thing_id`) VALUES
(29, 5865, 52450, 337);

-- --------------------------------------------------------

--
-- Estrutura da tabela `reserved`
--

CREATE TABLE `reserved` (
  `id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `thing_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `reserved`
--

INSERT INTO `reserved` (`id`, `date`, `thing_id`) VALUES
(4, '2024-02-18 00:35:31', 252),
(5, '2024-03-05 18:50:59', 251),
(6, '2024-03-11 16:24:13', 250),
(7, '2024-08-31 19:00:56', 256),
(8, '2024-09-16 16:51:34', 257),
(9, '2024-09-19 17:04:16', 261),
(10, '2024-09-19 17:05:24', 260),
(11, '2024-09-19 17:05:53', 259),
(12, '2024-09-19 17:06:21', 258),
(13, '2024-09-19 18:10:12', 255),
(14, '2024-09-19 18:34:48', 262),
(15, '2024-11-13 14:34:35', 337);

-- --------------------------------------------------------

--
-- Estrutura da tabela `returned`
--

CREATE TABLE `returned` (
  `id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `thing_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `returned`
--

INSERT INTO `returned` (`id`, `date`, `thing_id`) VALUES
(1, '2024-09-19 18:35:56', 262),
(2, '2024-11-13 11:58:59', 268),
(3, '2024-11-13 13:02:16', 338),
(4, '2024-11-13 13:02:39', 312),
(5, '2024-11-13 13:22:20', 261),
(6, '2024-11-13 13:22:54', 253),
(7, '2024-11-13 13:23:28', 254),
(8, '2024-11-13 13:23:56', 260),
(9, '2024-11-13 13:24:25', 255),
(10, '2024-11-13 13:24:42', 256),
(11, '2024-11-13 13:25:18', 259),
(12, '2024-11-13 13:25:49', 258),
(13, '2024-11-13 13:26:20', 257);

-- --------------------------------------------------------

--
-- Estrutura da tabela `things`
--

CREATE TABLE `things` (
  `id` int(11) NOT NULL,
  `description` text DEFAULT NULL,
  `local` varchar(100) NOT NULL,
  `date` timestamp NULL DEFAULT current_timestamp(),
  `returned_status` tinyint(1) DEFAULT 0,
  `reserved_status` tinyint(1) DEFAULT 0,
  `category_id` int(11) NOT NULL DEFAULT 0,
  `image_address` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `things`
--

INSERT INTO `things` (`id`, `description`, `local`, `date`, `returned_status`, `reserved_status`, `category_id`, `image_address`) VALUES
(250, '', 'Sala 1', '2024-02-17 20:52:53', 0, 0, 90, 'deletado:{api/assets/imgs/f4cc5088a7d43d905f02ff59b9934b31.png}'),
(251, '', 'Lab 3', '2024-02-17 20:53:11', 0, 0, 89, 'deletado:{api/assets/imgs/5fe654fb9c7bb27d835a99a22274a36e.png}'),
(252, '', 'Lab 1', '2024-02-17 20:53:35', 0, 0, 88, 'deletado:{api/assets/imgs/5c28f5a011e284373e4326430b087bdb.jpeg}'),
(253, '', 'Lab 3', '2024-08-30 18:15:24', 1, 0, 88, 'api/assets/imgs/40e1329e8f28f0e3e4a158a16bdc0595.jpeg'),
(254, '', 'RU 2', '2024-08-30 18:16:48', 1, 0, 89, 'api/assets/imgs/5bda0e780c5b675965a66bdf00ca41e4.jpeg'),
(255, '', 'Sala 01', '2024-08-31 18:57:32', 1, 0, 90, 'api/assets/imgs/6cde1e1cd2abfe39fe7e9c8673233e82.jpeg'),
(256, '', 'Sala 06', '2024-08-31 18:57:52', 1, 0, 104, 'api/assets/imgs/e64d301da7cc34325e1cc767689d1873.jpeg'),
(257, '', 'Lab 3', '2024-08-31 18:58:10', 1, 0, 102, 'api/assets/imgs/2f2e74ec454f2b10e9b72d871cf33f08.jpeg'),
(258, '', 'Lab 6', '2024-09-19 17:00:45', 1, 0, 102, 'api/assets/imgs/d51c16ca8466f9f2073a1a93712e5de3.png'),
(259, 'Carteira', 'Lab 1', '2024-09-19 17:01:04', 1, 0, 104, 'api/assets/imgs/344d0ee8ad225186544ff4683fb23663.png'),
(260, 'Capinha madeira', 'Lab 3', '2024-09-19 17:01:34', 1, 0, 104, 'api/assets/imgs/8c0f1a453e238fb9f9a7c241c5a6684c.jpeg'),
(261, 'Chuchinha', 'Lab 2', '2024-09-19 17:02:06', 1, 0, 103, 'api/assets/imgs/72e75ba8159fc86f3bf733def06b1908.png'),
(262, 'Smartphone', 'Laboratório 6', '2023-09-19 18:31:37', 1, 1, 88, 'deletado:{api/assets/imgs/5c7da563a18ebcb8c87bd0475d886778.png}'),
(263, 'Guarda-chuva', 'Bloco smd', '2024-11-11 14:39:33', 0, 0, 90, 'api/assets/imgs/c84dbe58f049b561bab043356bc1b4d8.jpeg'),
(264, 'Guarda-chuva', 'Bloco smd', '2024-11-11 14:41:07', 0, 0, 90, 'api/assets/imgs/24b7976b868a0cb6c9fe2bd0aa3bd86c.jpeg'),
(265, 'Caderno', 'Bloco smd', '2024-11-11 14:43:23', 0, 0, 102, 'api/assets/imgs/153c604ef642658cbe0d09e7f4e17683.jpeg'),
(266, 'Agenda', 'Bloco smd', '2024-11-11 14:44:29', 0, 0, 102, 'api/assets/imgs/4164b77f79575da0da3f6ca4a3e74466.jpeg'),
(267, 'Caderno', 'Bloco smd', '2024-11-11 14:45:42', 0, 0, 102, 'api/assets/imgs/f783b2405cbe586d614a6fd7a28d2bdf.jpeg'),
(268, 'Agenda', 'Bloco smd', '2024-11-11 14:46:22', 1, 0, 102, 'api/assets/imgs/c01367fe411096615207f3047e4c94b3.jpeg'),
(269, 'Pente', 'Bloco smd', '2024-11-11 14:48:30', 0, 0, 104, 'api/assets/imgs/2452ee48c4b83ff4806e44861c9af8fe.jpeg'),
(270, 'Chaves', 'Bloco smd', '2024-11-11 14:49:06', 0, 0, 104, 'api/assets/imgs/277236960f19573c837927255f2ae010.jpeg'),
(271, 'Chaves', 'Bloco smd', '2024-11-11 14:49:42', 0, 0, 104, 'api/assets/imgs/835a2e9159a2882276decfe8430ab384.jpeg'),
(272, 'Escova de dente', 'Bloco smd', '2024-11-11 14:50:34', 0, 0, 104, 'api/assets/imgs/494275830949f16c55b70c16463a6c8a.jpeg'),
(273, 'Bijureria', 'Bloco smd', '2024-11-11 14:51:05', 0, 0, 103, 'api/assets/imgs/1953d587ed947cb1d1d3181ab7c0a21c.jpeg'),
(274, 'Brinco', 'Bloco smd', '2024-11-11 14:51:36', 0, 0, 103, 'api/assets/imgs/ddd1ca4da67dd46274cf732e59373575.jpeg'),
(275, 'Anel', 'Bloco smd', '2024-11-11 14:52:07', 0, 0, 103, 'api/assets/imgs/95d6cd71acad0cda0fcd12528b420c72.jpeg'),
(276, 'Anel', 'Bloco smd', '2024-11-11 14:52:39', 0, 0, 103, 'api/assets/imgs/0c1a521a0a153950a92a1ceb10114b2a.jpeg'),
(277, 'Cabo', 'Bloco smd', '2024-11-11 14:53:10', 0, 0, 88, 'api/assets/imgs/765bf92967b0362b17014c4629b25a6c.jpeg'),
(278, 'Chave', 'Bloco smd', '2024-11-11 14:53:38', 0, 0, 104, 'api/assets/imgs/0c9c7e9988f29b02b70dc724b92c4c83.jpeg'),
(279, 'Mouse', 'Bloco smd', '2024-11-11 14:54:23', 0, 0, 88, 'api/assets/imgs/6d84da89f3675ffc44eb0b0be3b3cba9.jpeg'),
(280, 'Chaves', 'Bloco smd', '2024-11-11 14:55:27', 0, 0, 104, 'api/assets/imgs/03801c69c9637e7806939814faf0fa7e.jpeg'),
(281, 'Chaves', 'Bloco smd', '2024-11-11 14:56:10', 0, 0, 104, 'api/assets/imgs/f3fa75fcacdc7f3d52b40d18669e1adf.jpeg'),
(282, 'Chaves', 'Bloco smd', '2024-11-11 14:56:35', 0, 0, 104, 'api/assets/imgs/aedad43fc0ccc388a740ce2cc97dd882.jpeg'),
(283, 'Bolsa', 'Bloco smd', '2024-11-11 14:57:03', 0, 0, 104, 'api/assets/imgs/061a2f1c83830649a86d3728d071619e.jpeg'),
(284, '', 'Bloco smd', '2024-11-11 14:57:37', 0, 0, 88, 'api/assets/imgs/c65866d82e6f56e029ab744975ae0a6d.jpeg'),
(285, 'Papelaria', 'Bloco smd', '2024-11-11 14:58:13', 0, 0, 103, 'api/assets/imgs/2204940eb52656d83d55de313cf4dfad.jpeg'),
(286, 'Cartão', 'Bloco smd', '2024-11-11 14:58:47', 0, 0, 104, 'api/assets/imgs/bfa03548762d3e8eac799b33376a3dc9.jpeg'),
(287, 'Cartão', 'Bloco smd', '2024-11-11 14:59:39', 0, 0, 104, 'api/assets/imgs/c5a4d5ec2008f75431a018e6927dcc8f.jpeg'),
(288, 'Cartão', 'Bloco smd', '2024-11-11 15:00:25', 0, 0, 104, 'api/assets/imgs/e301bd8c53392f9d93283ddb78b35851.jpeg'),
(289, 'Cartão', 'Bloco smd', '2024-11-11 15:01:28', 0, 0, 104, 'api/assets/imgs/54244e43c798babb5e424abf1211ab10.jpeg'),
(290, 'Cartão', 'Bloco smd', '2024-11-11 15:02:11', 0, 0, 104, 'api/assets/imgs/4168a5c3ba2948e0733fb6e75c125b88.jpeg'),
(291, 'Cartão', 'Bloco smd', '2024-11-11 15:02:59', 0, 0, 104, 'api/assets/imgs/180232fdfa65fc63dc7357f8d0f3e31e.jpeg'),
(292, 'Cartão ', 'Bloco smd', '2024-11-11 15:03:37', 0, 0, 104, 'api/assets/imgs/de2beacec303dde9edd0e9e2b8fc2c04.jpeg'),
(293, 'Fone', 'Bloco smd', '2024-11-11 15:04:15', 0, 0, 88, 'api/assets/imgs/d17d121306baa65cd7031dcd5efa7a8c.jpeg'),
(294, '', 'Bloco smd', '2024-11-11 15:04:46', 0, 0, 88, 'api/assets/imgs/f43a46a9dc36f2f1263254459d1fa2cd.jpeg'),
(295, 'Fone', 'Bloco smd', '2024-11-11 15:05:33', 0, 0, 88, 'api/assets/imgs/b89cba53017c8fc9757122ed9add3268.jpeg'),
(296, 'Fone', 'Bloco smd', '2024-11-11 15:06:17', 0, 0, 88, 'api/assets/imgs/6c69ec590006846bc5e64da295dc745d.jpeg'),
(297, 'Estojo', 'Bloco smd', '2024-11-11 15:07:03', 0, 0, 102, 'api/assets/imgs/4d636e38b504bc2085ef073afde55fe4.jpeg'),
(298, 'Estojo', 'Bloco smd', '2024-11-11 15:08:23', 0, 0, 102, 'api/assets/imgs/874e049f5a79ecdc9cdef3947425deed.jpeg'),
(299, 'Estojo', 'Bloco smd', '2024-11-11 15:10:53', 0, 0, 102, 'api/assets/imgs/9037378a821b21400721962e3d6bead1.jpeg'),
(300, '', 'Bloco smd', '2024-11-11 15:12:39', 0, 0, 88, 'api/assets/imgs/f84719bbc979108af91676aebd24c168.jpeg'),
(301, '', 'Bloco smd', '2024-11-11 15:13:24', 0, 0, 88, 'api/assets/imgs/aa4c06ca0feeecbe01afc07a32b22a1e.jpeg'),
(302, '', 'Bloco smd', '2024-11-11 15:14:23', 0, 0, 88, 'api/assets/imgs/b7677023fbdfd139c3c755cca277df8c.jpeg'),
(303, 'Cueca', 'Bloco smd', '2024-11-11 15:15:37', 0, 0, 103, 'api/assets/imgs/2bc00fb439f60f592a8ce9c763cf3eaa.jpeg'),
(304, 'Blusa', 'Bloco smd', '2024-11-11 15:17:10', 0, 0, 103, 'api/assets/imgs/37070ec2baa1ce54243baa3e13d080bb.jpeg'),
(305, 'Boné', 'Bloco smd', '2024-11-11 15:18:01', 0, 0, 103, 'api/assets/imgs/c6e49a3fbb01cc514a861e64d5debd27.jpeg'),
(306, 'Boné', 'Bloco smd', '2024-11-11 15:18:43', 0, 0, 103, 'api/assets/imgs/24369f8ef050c3116c34cbcd47e79837.jpeg'),
(307, '', 'Bloco smd', '2024-11-11 15:19:21', 0, 0, 90, 'api/assets/imgs/969ead7fbe2ff43e0f6b73f036ec2743.jpeg'),
(308, 'Casaco de renda', 'Bloco smd', '2024-11-11 15:20:19', 0, 0, 103, 'api/assets/imgs/03a9c2cebe66237a0e05d049cb5b35da.jpeg'),
(309, '', 'Bloco smd', '2024-11-11 15:21:26', 0, 0, 90, 'api/assets/imgs/98ea7f7752834dab6bdd99b4fa94fefb.jpeg'),
(310, '', 'Bloco smd', '2024-11-11 15:22:03', 0, 0, 89, 'api/assets/imgs/6992772cc1526d94342afdeaca570bbf.jpeg'),
(311, '', 'Bloco smd', '2024-11-11 15:22:37', 0, 0, 90, 'api/assets/imgs/73063620b2fe4c8aaa5aafefa0002b10.jpeg'),
(312, 'Agenda', 'Bloco smd', '2024-11-11 15:23:21', 1, 0, 102, 'api/assets/imgs/a30af1d6e0fdb6235c8d79b9fac62edb.jpeg'),
(313, 'Pote', 'Bloco smd', '2024-11-11 15:23:48', 0, 0, 104, 'api/assets/imgs/72e9b92eee715a615cf0fd5bb77bb488.jpeg'),
(314, '', 'Bloco smd', '2024-11-11 15:24:20', 0, 0, 104, 'api/assets/imgs/177bd9da0602203ed3b780d45c07b3dc.jpeg'),
(315, '', 'Bloco smd', '2024-11-11 15:24:45', 0, 0, 89, 'api/assets/imgs/f6acca3cf639d301cb163f7e1c206aee.jpeg'),
(316, '', 'Bloco smd', '2024-11-11 15:25:09', 0, 0, 89, 'api/assets/imgs/e13df40c7af1dc47b279b18a8ffb0923.jpeg'),
(317, '', 'Bloco smd', '2024-11-11 15:25:46', 0, 0, 89, 'api/assets/imgs/8c2813d1618d38b2c8d987d086fa405e.jpeg'),
(318, '', 'Bloco smd', '2024-11-11 15:26:49', 0, 0, 89, 'api/assets/imgs/168a56c44b91bc986c9e01ac53f9e8b9.jpeg'),
(319, '', 'Bloco smd', '2024-11-11 15:28:02', 0, 0, 89, 'api/assets/imgs/f9eac1afffb6aec6d74e8b94ee032b04.jpeg'),
(320, '', 'Bloco smd', '2024-11-11 15:28:33', 0, 0, 89, 'api/assets/imgs/fa8576b596d75a686f42d16081827e13.jpeg'),
(321, '', 'Bloco smd', '2024-11-11 15:30:38', 0, 0, 89, 'api/assets/imgs/5aaa337e336aa56117f69029d1043e4c.jpeg'),
(322, '', 'Bloco smd', '2024-11-11 15:32:20', 0, 0, 89, 'api/assets/imgs/d15bbd4729028b40d0403139d8d3c3ad.jpeg'),
(323, 'Copo', 'Bloco smd', '2024-11-11 15:33:13', 0, 0, 89, 'api/assets/imgs/196176c1685e702bf58adaac120e490f.jpeg'),
(324, 'Copo', 'Bloco smd', '2024-11-11 15:34:17', 0, 0, 89, 'api/assets/imgs/c895a034f447c5b8c23760c40a12b002.jpeg'),
(325, '', 'Bloco smd', '2024-11-11 15:35:29', 0, 0, 89, 'api/assets/imgs/e5f586700dca5d6fe7ae6c4e7887375c.jpeg'),
(326, '', 'Bloco smd', '2024-11-11 15:37:55', 0, 0, 89, 'api/assets/imgs/9183c23e7673396e72516c5e4a2ee37b.jpeg'),
(327, '', 'Bloco smd', '2024-11-11 15:38:20', 0, 0, 89, 'api/assets/imgs/f769e410470644110e4509c38d38da04.jpeg'),
(328, '', 'Bloco smd', '2024-11-11 15:38:48', 0, 0, 89, 'api/assets/imgs/55b8a5f3da3c03afccc36a756bb32b70.jpeg'),
(329, '', 'Bloco smd', '2024-11-11 15:39:37', 0, 0, 89, 'api/assets/imgs/f2e4449bc491a3e94e721296df80c054.jpeg'),
(330, '', 'Bloco smd', '2024-11-11 15:40:10', 0, 0, 89, 'api/assets/imgs/30a6f4cd6943acbaa47d30d1eb1a1d7c.jpeg'),
(331, '', 'Bloco smd', '2024-11-11 15:40:45', 0, 0, 89, 'api/assets/imgs/eb93094f3cacf543b85072c0d953f07a.jpeg'),
(332, '', 'Bloco smd', '2024-11-11 15:41:39', 0, 0, 89, 'api/assets/imgs/c8acb028e85a231c847865be300ae5cd.jpeg'),
(333, '', 'Bloco smd', '2024-11-11 15:42:12', 0, 0, 89, 'api/assets/imgs/d0f79e1dfcb7d74282280418228f8997.jpeg'),
(334, '', 'Bloco smd', '2024-11-11 15:42:53', 0, 0, 89, 'api/assets/imgs/105ba8dd60351d7e3a47cd5a24ecfeb9.jpeg'),
(335, '', 'Bloco smd', '2024-11-11 15:43:21', 0, 0, 89, 'api/assets/imgs/a8f4bb2e80f18f8ee488e17c535adda7.jpeg'),
(336, '', 'Bloco smd', '2024-11-11 15:43:57', 0, 0, 89, 'api/assets/imgs/2ee693609659620373e2cbebe8b908a2.jpeg'),
(337, '', 'Bloco smd', '2024-11-11 15:44:26', 0, 1, 89, 'api/assets/imgs/9d66ebf7ac68f9bea1cc2bfb23d0e9e4.jpeg'),
(338, '', 'Bloco smd', '2024-11-11 18:09:38', 1, 0, 89, 'api/assets/imgs/75f57700203c8bac758379fbfceaf677.jpeg');

--
-- Acionadores `things`
--
DELIMITER $$
CREATE TRIGGER `after_things_update_reserved_filed` AFTER UPDATE ON `things` FOR EACH ROW BEGIN
    IF OLD.reserved_status = 0 AND NEW.reserved_status = 1 THEN
        INSERT INTO reserved
		SET date =  NOW(), thing_id = OLD.id;
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_things_update_returned_filed` AFTER UPDATE ON `things` FOR EACH ROW BEGIN
    IF NEW.returned_status = 1 AND OLD.returned_status = 0 THEN
        INSERT INTO returned
		SET date = NOW(), thing_id = OLD.id;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura stand-in para vista `thingsview`
-- (Veja abaixo para a view atual)
--
CREATE TABLE `thingsview` (
`id` int(11)
,`description` text
,`local` varchar(100)
,`date` timestamp
,`returned_status` tinyint(1)
,`reserved_status` tinyint(1)
,`image_address` varchar(64)
,`category_id` int(11)
,`category_name` varchar(50)
);

-- --------------------------------------------------------

--
-- Estrutura da tabela `zips`
--

CREATE TABLE `zips` (
  `id` int(11) NOT NULL,
  `file_address` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `zips`
--

INSERT INTO `zips` (`id`, `file_address`) VALUES
(1, 'api/assets/imgs/compress/imagens_compactada_16.09.24.02.18.zip'),
(2, 'api/assets/imgs/compress/imagens_compactada_19.09.24.03.40.zip');

-- --------------------------------------------------------

--
-- Estrutura para vista `thingsview`
--
DROP TABLE IF EXISTS `thingsview`;

CREATE ALGORITHM=UNDEFINED DEFINER=`u646553300_achai`@`127.0.0.1` SQL SECURITY DEFINER VIEW `thingsview`  AS SELECT `things`.`id` AS `id`, `things`.`description` AS `description`, `things`.`local` AS `local`, `things`.`date` AS `date`, `things`.`returned_status` AS `returned_status`, `things`.`reserved_status` AS `reserved_status`, `things`.`image_address` AS `image_address`, `categories`.`id` AS `category_id`, `categories`.`name` AS `category_name` FROM (`things` join `categories`) WHERE `things`.`category_id` = `categories`.`id` ;

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `emaillist`
--
ALTER TABLE `emaillist`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `addr` (`addr`);

--
-- Índices para tabela `listvalidationcodes`
--
ALTER TABLE `listvalidationcodes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `thing_id` (`thing_id`);

--
-- Índices para tabela `reserved`
--
ALTER TABLE `reserved`
  ADD PRIMARY KEY (`id`),
  ADD KEY `thing_id` (`thing_id`);

--
-- Índices para tabela `returned`
--
ALTER TABLE `returned`
  ADD PRIMARY KEY (`id`),
  ADD KEY `thing_id` (`thing_id`);

--
-- Índices para tabela `things`
--
ALTER TABLE `things`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`);

--
-- Índices para tabela `zips`
--
ALTER TABLE `zips`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `admins`
--
ALTER TABLE `admins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de tabela `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=106;

--
-- AUTO_INCREMENT de tabela `emaillist`
--
ALTER TABLE `emaillist`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de tabela `listvalidationcodes`
--
ALTER TABLE `listvalidationcodes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT de tabela `reserved`
--
ALTER TABLE `reserved`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de tabela `returned`
--
ALTER TABLE `returned`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de tabela `things`
--
ALTER TABLE `things`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=339;

--
-- AUTO_INCREMENT de tabela `zips`
--
ALTER TABLE `zips`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `listvalidationcodes`
--
ALTER TABLE `listvalidationcodes`
  ADD CONSTRAINT `listvalidationcodes_ibfk_1` FOREIGN KEY (`thing_id`) REFERENCES `things` (`id`);

--
-- Limitadores para a tabela `reserved`
--
ALTER TABLE `reserved`
  ADD CONSTRAINT `reserved_ibfk_1` FOREIGN KEY (`thing_id`) REFERENCES `things` (`id`);

--
-- Limitadores para a tabela `returned`
--
ALTER TABLE `returned`
  ADD CONSTRAINT `returned_ibfk_1` FOREIGN KEY (`thing_id`) REFERENCES `things` (`id`);

--
-- Limitadores para a tabela `things`
--
ALTER TABLE `things`
  ADD CONSTRAINT `things_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
