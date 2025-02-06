-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 28, 2024 at 03:42 AM
-- Server version: 8.0.30
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `faiz_ukkperpus`
--

-- --------------------------------------------------------

--
-- Table structure for table `buku`
--

CREATE TABLE `buku` (
  `BukuID` int NOT NULL,
  `Judul` varchar(255) DEFAULT NULL,
  `Penulis` varchar(255) DEFAULT NULL,
  `Penerbit` varchar(255) DEFAULT NULL,
  `TahunTerbit` int DEFAULT NULL,
  `Stok` int NOT NULL,
  `Gambar` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `buku`
--

INSERT INTO `buku` (`BukuID`, `Judul`, `Penulis`, `Penerbit`, `TahunTerbit`, `Stok`, `Gambar`) VALUES
(1, 'Dongeng Si Kancil dan Teman-temannya', 'Mulasih Tary', 'Elex Media Komputindo', 2014, 0, 'sampulbuku/Dongeng_Si_Kancil_dan_Teman-temannya_20241120073530.jfif'),
(2, 'Harry Potter', 'Joanne Rowling', 'Pena J.K. Rowling', 2005, 99, 'sampulbuku/Harry_Potter_20241120073831.jpg'),
(3, 'A Brief History Of Time', 'Stephen Hawking', 'SH Media', 1990, 97, 'sampulbuku/A_Brief_History_Of_Time_20241120073942.jpg'),
(4, 'Pulang ', 'Tere Liye', 'TLMedia', 2023, 94, 'sampulbuku/Pulang__20241122085910.jpg'),
(5, 'Greatest Off All Time', 'Gunawan', 'GOAT Media', 2022, 100, 'sampulbuku/Greatest_Off_All_Time_20241122085604.jpeg'),
(6, 'Naruto', 'Masashi Kishimoto', 'MK Media', 2014, 98, 'sampulbuku/Naruto_20241124173645.jpg');

--
-- Triggers `buku`
--
DELIMITER $$
CREATE TRIGGER `after_delete_buku` AFTER DELETE ON `buku` FOR EACH ROW BEGIN
    INSERT INTO logaktivitas (UserID, Aksi, Tanggal)
    VALUES (
        @current_user_id, 
        CONCAT('Menghapus buku: "', OLD.Judul, '" (Penulis: ', OLD.Penulis, ')'), 
        NOW()
    );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_insert_buku` AFTER INSERT ON `buku` FOR EACH ROW BEGIN
    INSERT INTO logaktivitas (UserID, Aksi, Tanggal)
    VALUES (
        @current_user_id, 
        CONCAT('Menambah buku: "', NEW.Judul, '" (Penulis: ', NEW.Penulis, ')'), 
        NOW()
    );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_update_buku` AFTER UPDATE ON `buku` FOR EACH ROW BEGIN
    INSERT INTO logaktivitas (UserID, Aksi, Tanggal)
    VALUES (
        @current_user_id, 
        CONCAT('Mengubah buku: "', NEW.Judul, '"'), 
        NOW()
    );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `kategoribuku`
--

CREATE TABLE `kategoribuku` (
  `KategoriID` int NOT NULL,
  `NamaKategori` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `kategoribuku`
--

INSERT INTO `kategoribuku` (`KategoriID`, `NamaKategori`) VALUES
(1, 'Fiksi'),
(2, 'Non-Fiksi'),
(3, 'Sains'),
(4, 'Psikologi'),
(5, 'Sejarah'),
(6, 'Agama'),
(7, 'Filsafat'),
(8, 'Seni'),
(9, 'Anak-anak'),
(10, 'Pengembangan Diri');

--
-- Triggers `kategoribuku`
--
DELIMITER $$
CREATE TRIGGER `after_delete_kategori` AFTER DELETE ON `kategoribuku` FOR EACH ROW BEGIN
    INSERT INTO logaktivitas (UserID, Aksi, Tanggal)
    VALUES (
        @current_user_id, 
        CONCAT('Menghapus kategori: "', OLD.NamaKategori, '"'), 
        NOW()
    );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_insert_kategori` AFTER INSERT ON `kategoribuku` FOR EACH ROW BEGIN
    INSERT INTO logaktivitas (UserID, Aksi, Tanggal)
    VALUES (
        @current_user_id, 
        CONCAT('Menambah kategori: ', NEW.NamaKategori), 
        NOW()
    );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_update_kategori` AFTER UPDATE ON `kategoribuku` FOR EACH ROW BEGIN
    INSERT INTO logaktivitas (UserID, Aksi, Tanggal)
    VALUES (
        @current_user_id, 
        CONCAT('Mengubah kategori dari "', OLD.NamaKategori, '" menjadi "', NEW.NamaKategori, '"'), 
        NOW()
    );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `kategoribuku_relasi`
--

CREATE TABLE `kategoribuku_relasi` (
  `KategoriBukuID` int NOT NULL,
  `BukuID` int NOT NULL,
  `KategoriID` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `kategoribuku_relasi`
--

INSERT INTO `kategoribuku_relasi` (`KategoriBukuID`, `BukuID`, `KategoriID`) VALUES
(5, 3, 2),
(6, 3, 3),
(7, 3, 7),
(14, 2, 1),
(15, 2, 3),
(21, 1, 1),
(22, 1, 9),
(23, 5, 2),
(24, 5, 5),
(25, 5, 10),
(26, 4, 2),
(27, 4, 4),
(28, 4, 7),
(29, 4, 10),
(33, 6, 1);

-- --------------------------------------------------------

--
-- Table structure for table `koleksipribadi`
--

CREATE TABLE `koleksipribadi` (
  `KoleksiID` int NOT NULL,
  `UserID` int NOT NULL,
  `BukuID` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `koleksipribadi`
--

INSERT INTO `koleksipribadi` (`KoleksiID`, `UserID`, `BukuID`) VALUES
(21, 22, 4),
(22, 22, 5),
(23, 22, 3),
(24, 22, 2),
(25, 22, 6),
(26, 24, 6),
(27, 24, 4);

-- --------------------------------------------------------

--
-- Table structure for table `logaktivitas`
--

CREATE TABLE `logaktivitas` (
  `LogID` int NOT NULL,
  `UserID` int NOT NULL,
  `Aksi` varchar(255) NOT NULL,
  `Tanggal` timestamp NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `logaktivitas`
--

INSERT INTO `logaktivitas` (`LogID`, `UserID`, `Aksi`, `Tanggal`) VALUES
(1, 19, 'Menambah kategori: neni', '2024-11-23 05:30:41'),
(2, 19, 'Menghapus kategori: \"neni\"', '2024-11-23 07:01:37'),
(3, 19, 'Mengubah kategori dari \"tes\" menjadi \"tes1\"', '2024-11-23 07:01:55'),
(4, 1, 'Mengubah kategori dari \"tes1\" menjadi \"tes12\"', '2024-11-23 07:03:46'),
(5, 20, 'Menghapus kategori: \"tes12\"', '2024-11-23 07:05:23'),
(6, 20, 'Menambah kategori: tes', '2024-11-24 10:28:52'),
(7, 20, 'Mengubah kategori dari \"tes\" menjadi \"tes1\"', '2024-11-24 10:28:58'),
(8, 20, 'Menghapus kategori: \"tes1\"', '2024-11-24 10:29:03'),
(9, 20, 'Menambah buku: \"Naruto\" (Penulis: Masashi Kishimoto)', '2024-11-24 10:30:54'),
(10, 20, 'Menambah buku: \"Boruto\" (Penulis: MK)', '2024-11-24 10:33:48'),
(11, 20, 'Mengubah buku: \"Naruto\"', '2024-11-24 10:33:55'),
(12, 20, 'Mengubah buku: \"Naruto\"', '2024-11-24 10:36:14'),
(13, 20, 'Menghapus buku: \"Boruto\" (Penulis: MK)', '2024-11-24 10:36:18'),
(14, 20, 'Mengubah buku: \"Naruto\"', '2024-11-24 10:36:33'),
(15, 20, 'Mengubah buku: \"Naruto\"', '2024-11-24 10:36:45'),
(16, 20, 'Mengubah buku: \"A Brief History Of Time\"', '2024-11-24 10:42:13'),
(17, 1, 'Menambah user: \"hernando1\"', '2024-11-24 10:46:03'),
(18, 1, 'Mengubah user: \"hernando12\"', '2024-11-24 10:46:19'),
(19, 20, 'Menambah peminjaman ke: \"Hernando1\", buku: \"Dongeng Si Kancil dan Teman-temannya\"', '2024-11-24 10:47:09'),
(20, 20, 'Mengubah buku: \"Dongeng Si Kancil dan Teman-temannya\"', '2024-11-24 10:47:09'),
(21, 20, 'Menambah peminjaman ke: \"Hernando1\", buku: \"A Brief History Of Time\"', '2024-11-24 10:47:18'),
(22, 20, 'Mengubah buku: \"A Brief History Of Time\"', '2024-11-24 10:47:18'),
(23, 20, 'Menambah peminjaman ke: \"Hernando1\", buku: \"Naruto\"', '2024-11-24 10:47:30'),
(24, 20, 'Mengubah buku: \"Naruto\"', '2024-11-24 10:47:30'),
(25, 20, 'Mengubah buku: \"A Brief History Of Time\"', '2024-11-24 10:48:57'),
(26, 20, 'Mengubah buku: \"Pulang \"', '2024-11-24 10:49:05'),
(27, 1, 'Menghapus user: \"ynr\"', '2024-11-24 15:47:28'),
(28, 20, 'Mengubah buku: \"A Brief History Of Time\"', '2024-11-24 16:49:27'),
(29, 20, 'Mengubah buku: \"A Brief History Of Time\"', '2024-11-24 17:24:06'),
(30, 20, 'Menambah peminjaman ke: \"Hernando1\", buku: \"Harry Potter\"', '2024-11-24 17:50:26'),
(31, 20, 'Mengubah buku: \"Harry Potter\"', '2024-11-24 17:50:26'),
(32, 20, 'Mengubah buku: \"Harry Potter\"', '2024-11-24 17:50:30'),
(33, 20, 'Menambah peminjaman ke: \"Hernando1\", buku: \"Pulang \"', '2024-11-24 17:50:38'),
(34, 20, 'Mengubah buku: \"Pulang \"', '2024-11-24 17:50:38'),
(35, 20, 'Mengubah buku: \"Pulang \"', '2024-11-24 17:50:41'),
(36, 1, 'Mengubah user: \"ynr123\"', '2024-11-24 17:58:36'),
(37, 24, 'Mengubah buku: \"Pulang \"', '2024-11-24 18:03:52'),
(38, 19, 'Mengubah buku: \"Pulang \"', '2024-11-24 18:05:30'),
(39, 24, 'Mengubah buku: \"Naruto\"', '2024-11-24 18:24:31'),
(40, 19, 'Mengubah buku: \"Pulang \"', '2024-11-24 18:24:48'),
(41, 24, 'Mengubah buku: \"Pulang \"', '2024-11-24 18:25:25'),
(42, 19, 'Mengubah buku: \"Pulang \"', '2024-11-24 18:25:47'),
(43, 19, 'Mengubah buku: \"Pulang \"', '2024-11-24 18:29:10'),
(44, 19, 'Mengubah buku: \"Naruto\"', '2024-11-24 18:29:32'),
(45, 19, 'Mengubah buku: \"Naruto\"', '2024-11-24 18:31:37'),
(46, 19, 'Mengubah buku: \"Naruto\"', '2024-11-24 18:31:46'),
(47, 24, 'Mengubah buku: \"A Brief History Of Time\"', '2024-11-27 23:03:51'),
(48, 19, 'Mengubah buku: \"Pulang \"', '2024-11-27 23:04:59'),
(49, 19, 'Mengubah buku: \"A Brief History Of Time\"', '2024-11-27 23:05:11'),
(50, 19, 'Mengubah buku: \"A Brief History Of Time\"', '2024-11-27 23:05:28'),
(51, 24, 'Mengubah buku: \"A Brief History Of Time\"', '2024-11-27 23:05:35'),
(52, 19, 'Mengubah buku: \"Naruto\"', '2024-11-27 23:15:34'),
(53, 24, 'Mengubah buku: \"Harry Potter\"', '2024-11-27 23:15:42');

-- --------------------------------------------------------

--
-- Table structure for table `peminjaman`
--

CREATE TABLE `peminjaman` (
  `PeminjamanID` int NOT NULL,
  `UserID` int NOT NULL,
  `BukuID` int NOT NULL,
  `TanggalPeminjaman` date DEFAULT NULL,
  `TanggalPengembalian` date DEFAULT NULL,
  `StatusPeminjaman` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `peminjaman`
--

INSERT INTO `peminjaman` (`PeminjamanID`, `UserID`, `BukuID`, `TanggalPeminjaman`, `TanggalPengembalian`, `StatusPeminjaman`) VALUES
(9, 22, 1, '2024-11-24', '2024-12-01', 'Selesai'),
(10, 22, 3, '2024-11-24', '2024-12-01', 'Selesai'),
(11, 22, 6, '2024-11-08', '2024-11-22', 'Selesai'),
(12, 22, 2, '2024-11-24', '2024-12-01', 'Selesai'),
(13, 22, 4, '2024-11-24', '2024-12-01', 'Selesai'),
(16, 24, 4, '2024-11-25', '2024-12-02', 'Selesai'),
(17, 24, 6, '2024-11-25', '2024-12-02', 'Selesai'),
(18, 24, 4, '2024-11-25', '2024-12-02', 'Dipinjam'),
(19, 24, 4, '2024-11-24', '2024-12-01', 'Selesai'),
(20, 24, 6, '2024-11-24', '2024-12-01', 'Selesai'),
(21, 24, 3, '2024-11-28', '2024-12-05', 'Selesai'),
(22, 24, 3, '2024-11-28', '2024-12-05', 'Tertunda');

-- --------------------------------------------------------

--
-- Table structure for table `pengembalian`
--

CREATE TABLE `pengembalian` (
  `PengembalianID` int NOT NULL,
  `PeminjamanID` int NOT NULL,
  `TanggalDikembalikan` date DEFAULT NULL,
  `Denda` varchar(255) DEFAULT NULL,
  `NilaiDenda` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `pengembalian`
--

INSERT INTO `pengembalian` (`PengembalianID`, `PeminjamanID`, `TanggalDikembalikan`, `Denda`, `NilaiDenda`) VALUES
(12, 9, '2024-11-24', 'Rusak', 10000),
(13, 11, '2024-11-24', 'Terlambat', 10000),
(14, 11, '2024-11-24', 'Rusak', 100000),
(15, 10, '2024-11-25', NULL, NULL),
(16, 12, '2024-11-25', NULL, NULL),
(17, 13, '2024-11-25', NULL, NULL),
(18, 16, '2024-11-25', NULL, NULL),
(19, 19, '2024-11-25', NULL, NULL),
(20, 17, '2024-11-25', NULL, NULL),
(21, 21, '2024-11-28', NULL, NULL),
(22, 20, '2024-11-28', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `ulasanbuku`
--

CREATE TABLE `ulasanbuku` (
  `UlasanID` int NOT NULL,
  `UserID` int NOT NULL,
  `BukuID` int NOT NULL,
  `Ulasan` text,
  `Rating` int DEFAULT NULL,
  `Tanggal` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `ulasanbuku`
--

INSERT INTO `ulasanbuku` (`UlasanID`, `UserID`, `BukuID`, `Ulasan`, `Rating`, `Tanggal`) VALUES
(6, 22, 1, 'b aja', 1, '2024-11-25 00:52:06'),
(7, 24, 4, 'keren terharu sedih', 5, '2024-11-25 01:25:01');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `UserID` int NOT NULL,
  `Username` varchar(255) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `Role` varchar(10) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `NamaLengkap` varchar(255) DEFAULT NULL,
  `Alamat` text,
  `Status` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`UserID`, `Username`, `Password`, `Role`, `Email`, `NamaLengkap`, `Alamat`, `Status`) VALUES
(1, 'admin', 'scrypt:32768:8:1$qofhdY4g3TgHE4zl$8766faeb8175cc71d698678a86123685914452969165db30cf720efdad0ebdc1df08006df45bd52c664b70d011f2ae78162ec498d6586c539253b26eea8dda8f', 'admin', 'admin@gmail.com', 'Admin ', 'admin', 'Terverifikasi'),
(18, 'faizsol', 'scrypt:32768:8:1$eKFDZW6w9q2UTrcN$474ac7316e1237760852419e58b6cae95aa65ba2fbbcae676ac5f0aa60db9270876c69bc798cf04d345b3fcb0f8263d560e97eac24c329a3e1ab86961e684fa3', 'peminjam', 'faiz@gmail.com', 'faiz', 'faiz', 'Pending'),
(19, 'petugas', 'scrypt:32768:8:1$aPrTwpZtKeoufZu7$c3fb60b07e6250a5630d63926b913b3d4be173deee18201f9360466d216a14622ba403ac258649faaf155e8a455a0a19c25fa66e96b3760bf3d5a82471064993', 'petugas', 'petugas@gmail.com', 'Si Petugas', 'y', 'Terverifikasi'),
(20, 'dede sapyudin', 'scrypt:32768:8:1$oWT3ROfQiYmFEzHC$f680fb16852ac05e5a9d5e1c73e44c145599c09cb019a8d8fd21c03fb907b53aa61e54bba0c0b502578b1da82268bd5ced5c53189e527056bcab6077affd9357', 'petugas', 'dede@gmail.com', 'dde', 'gg h manaf', 'Terverifikasi'),
(22, 'hernando12', 'scrypt:32768:8:1$6qIvHoOIenjpyC2D$d74d9a7d601fcb7fe516e13519aa485b02abdeca0d5c637e3607f49a57b4ea41b5ed5ed17879ae5fc8d510e838655b9bd428c17c0db171f5733b06d7333ebdae', 'peminjam', 'hernando1@gmail.com', 'Hernando1', 'Bantull', 'Terverifikasi'),
(24, 'ynr123', 'scrypt:32768:8:1$X1YP5mI0cRJkn0CE$cb7bccfeadd11ff1cd8ad8fdbe01498e4df2bc5735da984d0c14a6b84c5aaa919f36eaaf6fffbfacbfa1b96fb1a63ba3b59ec827e32b061aec0a5f2151a8d14b', 'peminjam', 'yanuar@gmail.com', 'Yanuar', 'Surabaya', 'Terverifikasi');

--
-- Triggers `user`
--
DELIMITER $$
CREATE TRIGGER `after_delete_user` AFTER DELETE ON `user` FOR EACH ROW BEGIN
    INSERT INTO logaktivitas (UserID, Aksi, Tanggal)
    VALUES (
        @current_user_id, 
        CONCAT('Menghapus user: "', OLD.Username, '"'), 
        NOW()
    );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_update_user` AFTER UPDATE ON `user` FOR EACH ROW BEGIN
    INSERT INTO logaktivitas (UserID, Aksi, Tanggal)
    VALUES (
        @current_user_id, 
        CONCAT('Mengubah user: "', NEW.Username, '"'), 
        NOW()
    );
END
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `buku`
--
ALTER TABLE `buku`
  ADD PRIMARY KEY (`BukuID`);

--
-- Indexes for table `kategoribuku`
--
ALTER TABLE `kategoribuku`
  ADD PRIMARY KEY (`KategoriID`);

--
-- Indexes for table `kategoribuku_relasi`
--
ALTER TABLE `kategoribuku_relasi`
  ADD PRIMARY KEY (`KategoriBukuID`),
  ADD KEY `BukuID` (`BukuID`),
  ADD KEY `KategoriID` (`KategoriID`);

--
-- Indexes for table `koleksipribadi`
--
ALTER TABLE `koleksipribadi`
  ADD PRIMARY KEY (`KoleksiID`),
  ADD KEY `UserID` (`UserID`),
  ADD KEY `BukuID` (`BukuID`);

--
-- Indexes for table `logaktivitas`
--
ALTER TABLE `logaktivitas`
  ADD PRIMARY KEY (`LogID`),
  ADD KEY `UserID` (`UserID`);

--
-- Indexes for table `peminjaman`
--
ALTER TABLE `peminjaman`
  ADD PRIMARY KEY (`PeminjamanID`),
  ADD KEY `UserID` (`UserID`),
  ADD KEY `BukuID` (`BukuID`);

--
-- Indexes for table `pengembalian`
--
ALTER TABLE `pengembalian`
  ADD PRIMARY KEY (`PengembalianID`),
  ADD KEY `PeminjamanID` (`PeminjamanID`);

--
-- Indexes for table `ulasanbuku`
--
ALTER TABLE `ulasanbuku`
  ADD PRIMARY KEY (`UlasanID`),
  ADD KEY `UserID` (`UserID`),
  ADD KEY `BukuID` (`BukuID`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`UserID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `buku`
--
ALTER TABLE `buku`
  MODIFY `BukuID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `kategoribuku`
--
ALTER TABLE `kategoribuku`
  MODIFY `KategoriID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `kategoribuku_relasi`
--
ALTER TABLE `kategoribuku_relasi`
  MODIFY `KategoriBukuID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `koleksipribadi`
--
ALTER TABLE `koleksipribadi`
  MODIFY `KoleksiID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `logaktivitas`
--
ALTER TABLE `logaktivitas`
  MODIFY `LogID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT for table `peminjaman`
--
ALTER TABLE `peminjaman`
  MODIFY `PeminjamanID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `pengembalian`
--
ALTER TABLE `pengembalian`
  MODIFY `PengembalianID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `ulasanbuku`
--
ALTER TABLE `ulasanbuku`
  MODIFY `UlasanID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `UserID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `kategoribuku_relasi`
--
ALTER TABLE `kategoribuku_relasi`
  ADD CONSTRAINT `kategoribuku_relasi_ibfk_1` FOREIGN KEY (`BukuID`) REFERENCES `buku` (`BukuID`),
  ADD CONSTRAINT `kategoribuku_relasi_ibfk_2` FOREIGN KEY (`KategoriID`) REFERENCES `kategoribuku` (`KategoriID`);

--
-- Constraints for table `koleksipribadi`
--
ALTER TABLE `koleksipribadi`
  ADD CONSTRAINT `koleksipribadi_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `user` (`UserID`),
  ADD CONSTRAINT `koleksipribadi_ibfk_2` FOREIGN KEY (`BukuID`) REFERENCES `buku` (`BukuID`);

--
-- Constraints for table `logaktivitas`
--
ALTER TABLE `logaktivitas`
  ADD CONSTRAINT `logaktivitas_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `user` (`UserID`);

--
-- Constraints for table `peminjaman`
--
ALTER TABLE `peminjaman`
  ADD CONSTRAINT `peminjaman_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `user` (`UserID`),
  ADD CONSTRAINT `peminjaman_ibfk_2` FOREIGN KEY (`BukuID`) REFERENCES `buku` (`BukuID`);

--
-- Constraints for table `pengembalian`
--
ALTER TABLE `pengembalian`
  ADD CONSTRAINT `pengembalian_ibfk_1` FOREIGN KEY (`PeminjamanID`) REFERENCES `peminjaman` (`PeminjamanID`);

--
-- Constraints for table `ulasanbuku`
--
ALTER TABLE `ulasanbuku`
  ADD CONSTRAINT `ulasanbuku_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `user` (`UserID`),
  ADD CONSTRAINT `ulasanbuku_ibfk_2` FOREIGN KEY (`BukuID`) REFERENCES `buku` (`BukuID`);

DELIMITER $$
--
-- Events
--
CREATE DEFINER=`root`@`localhost` EVENT `delete_expired_peminjaman` ON SCHEDULE EVERY 1 DAY STARTS '2024-11-28 06:16:28' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
    -- Hapus peminjaman yang statusnya 'Tertunda' 
    -- dan tanggal peminjaman <= hari ini 
    -- dan waktu saat ini sudah lewat dari jam 17:00
    DELETE FROM peminjaman
    WHERE StatusPeminjaman = 'Tertunda'
    AND TanggalPeminjaman <= CURRENT_DATE()
    AND CURRENT_TIME() > '17:00:00';
END$$

DELIMITER ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
