-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Czas generowania: 24 Lut 2024, 19:57
-- Wersja serwera: 10.4.27-MariaDB
-- Wersja PHP: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Baza danych: `aplikacjaturystyczna`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `filtr`
--

CREATE TABLE `filtr` (
  `Id_filtru` int(11) NOT NULL,
  `Kategoria` varchar(30) NOT NULL,
  `Rodzaj` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Zrzut danych tabeli `filtr`
--

INSERT INTO `filtr` (`Id_filtru`, `Kategoria`, `Rodzaj`) VALUES
(1, 'Muzeum', 'Sztuki'),
(2, 'Muzeum', 'Historii'),
(3, 'Natura', 'Park'),
(4, 'Natura', 'Zoo'),
(5, 'Rozrywka', 'Escape Room'),
(6, 'Rozrywka', 'Kino'),
(10, 'Outdoor', 'Plaża'),
(11, 'Zakupy', 'Centrum Handlowe'),
(12, 'Krajobraz', 'Stadion'),
(13, 'Krajobraz', 'Architektura'),
(14, 'Krajobraz', 'Zamek'),
(15, 'Muzeum', 'Specjalistyczne'),
(16, 'Rozrywka', 'Park Rozrywki'),
(17, 'Outdoor', 'Łowienie'),
(18, 'Outdoor', 'Rejsy'),
(19, 'Natura', 'Góry'),
(20, 'Custom', 'Uzytkownik');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `kraj`
--

CREATE TABLE `kraj` (
  `Id_kraju` int(11) NOT NULL,
  `Nazwa` varchar(30) NOT NULL,
  `Flaga` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Zrzut danych tabeli `kraj`
--

INSERT INTO `kraj` (`Id_kraju`, `Nazwa`, `Flaga`) VALUES
(1, 'Polska', 'polska.png'),
(2, 'Niemcy', 'niemcy.png');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `miejsce`
--

CREATE TABLE `miejsce` (
  `Id_miejsca` int(11) NOT NULL,
  `Nazwa` varchar(50) NOT NULL,
  `Zdjecie` varchar(50) NOT NULL,
  `Opis` varchar(200) NOT NULL,
  `Miasto` varchar(30) NOT NULL,
  `Adres` varchar(60) NOT NULL,
  `Koordynaty_x` decimal(17,15) NOT NULL,
  `Koordynaty_y` decimal(17,15) NOT NULL,
  `FK_id_kraju` int(11) NOT NULL,
  `FK_id_filtru` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Zrzut danych tabeli `miejsce`
--

INSERT INTO `miejsce` (`Id_miejsca`, `Nazwa`, `Zdjecie`, `Opis`, `Miasto`, `Adres`, `Koordynaty_x`, `Koordynaty_y`, `FK_id_kraju`, `FK_id_filtru`) VALUES
(1, 'Galeria Sztuki Epicentrum', 'GaleriaSztukiEpicentrum.jpg', 'Galeria Epicentrum swą działalność rozpoczęła 13 października 2000 roku. Od jedenastu lat ukazuje różne aspekty współczesnej plastyki, nie dokonując podziału na sztukę zawodową i amatorską.', 'Opole', 'plac Kopernika 6, 46-020', '50.668989913001930', '17.927473939591515', 1, 1),
(2, 'Muzeum Wsi Opolskiej', 'MuzeumWsiOpolskiej.jpg', 'Bierkowicki skansen to historia opolskiej wsi z okresu XVIII-XX wieku. Na ogromnym, zadrzewionym i zielonym terenie można zobaczyć kompletnie zrekonstruowane zagrody z drewnianymi chatami.', 'Opole', 'Wrocławska 174, 45-835', '50.682421457566235', '17.863586773756538', 1, 2),
(3, 'Muzeum Śląska Opolskiego', 'MuzeumSlaskaOpolskiego.jpg', 'Muzeum Śląska Opolskiego jest instytucją z ponad 120 letnią tradycją. Zostało założone w 1900 roku jako Muzeum Miejskie w Opolu (Städtisches Museum Oppeln).', 'Opole', 'św. Wojciecha 13, 45-023', '50.669033899177435', '17.924601384658160', 1, 2),
(4, 'Muzeum Polskiej Piosenki', 'MuzeumPolskiejPiosenki.jpg', 'Ekspozycja muzeum przedstawia w zarysie historię polskiej piosenki od lat 20. ubiegłego wieku do czasów współczesnych.', 'Opole', 'Piastowska 14A, 45-082', '50.667247882872060', '17.918143810984063', 1, 15),
(5, 'Chata Zagadek', 'ChataZagadek.jpg', 'Do dyspozycji Gości są trzy pokoje o różnym poziomie trudności - Kryptonim Dżungla, Sarkofag i Saloon. Zadaniem uczestników zabawy jest rozwiązanie serii zagadek.', 'Opole', 'Barlickiego 7, 45-083', '50.666069310323980', '17.919557746025514', 1, 5),
(6, 'Kino Helios Opole', 'KinoHeliosOpole.jpg', 'Helios S.A. to największa sieć kin w Polsce pod względem liczby obiektów.', 'Opole', 'plac Kopernika 16, 45-040', '50.670430801115590', '17.926152000005565', 1, 6),
(7, 'Opole Zoo', 'OpoleZoo.jpg', 'Zoo w Opolu zajmuje powierzchnię 20 ha i hoduje ponad 1000 zwierząt reprezentujących ponad 200 gatunków z całego świata. Zwierzęta żyją tu w bardzo pomysłowych i naturalnych zagrodach.', 'Opole', 'Spacerowa 10, 45-094', '50.655796429900840', '17.923154005061810', 1, 4),
(8, 'Centrum Handlowe Karolinka', 'CentrumHandloweKarolinka.jpg', 'Centrum Handlowe Karolinka w Opolu to kompleks łączący galerię handlową z parkiem handlowym. Łączna powierzchnia najmu Karolinki wynosi 70 tys. m², z czego prawie 38 tys. m² przypada na galerię.', 'Opole', 'Wrocławska 152/154, 45-837', '50.681754958061100', '17.877559578557403', 1, 11),
(9, 'Park Nadodrzański w Opolu', 'ParkNadorzanskiWOpolu.jpg', 'Są tu szerokie, malownicze alejki wzdłuż Odry, zielone polany oraz miejsca takie, jak siłownia na świeżym powietrzu.', 'Opole', 'Powstańców Śląskich 28, 46-020', '50.660426604698210', '17.918392471176528', 1, 3),
(10, 'Wieża Piastowska', 'WiezaPiastowska.jpg', 'Jeden z najlepszych punktów widokowych miasta i najbardziej znanych zabytków Opola. Ale też jeden z najstarszych obiektów architektury obronnej w Polsce.', 'Opole', 'Piastowska 14, 45-081', '50.667800686009690', '17.919635214794365', 1, 13),
(11, 'Katedra Podwyższenia Krzyża Świętego', 'KatedraPodwyzszeniaKrzyzaSwietego.jpg', 'Katedra ma charakter gotycki, a jej wieże powstały w stylu neogotyckim. Została zbudowana z cegły, a w starszych fragmentach murów występuje wątek wendyjski.', 'Opole', 'Katedralna 2, 45-007', '50.670445851093490', '17.920297336553480', 1, 13),
(12, 'Rynek w Opolu', 'RynekWOpolu.jpg', 'Centralny punkt stanowi czworoboczny Rynek, z efektownym, okazałym Ratuszem pośrodku. Wokół Rynku stoją śliczne kamienice ze zdobionymi fasadami, wymalowanymi pastelowymi barwami.', 'Opole', 'Rynek, 46-020', '50.668542727407930', '17.922469392480560', 1, 13),
(13, 'Zamek Górny', 'ZamekGorny.jpg', 'Wieża Zamku Górnego w Opolu to wieża ceglana o układzie gotyckim z zastosowaniem zendrówki w układzie rombowym.', 'Opole', 'Osmańczyka 22, 46-027', '50.669911399899340', '17.924639461645715', 1, 14),
(14, 'Stadion Miejski OKS Odra Opole', 'StadionMiejskiOKSOdraOpole.jpg', 'Stadion powstał w 1945, wraz z miejscową Odrą. Przez ponad pół wieku służył klubowi w niemal niezmienionej formie. Znaczne zmiany nadeszły w 2000 roku, gdy ruszyła budowa nowej trybuny południowej.', 'Opole', 'Oleska 51, 46-020', '50.676408813293280', '17.932023738175086', 1, 12),
(15, 'Moszna Zamek', 'MosznaZamek.jpg', 'Zamek Moszna to zabytkowa budowla posiadająca 365 pomieszczeń, 99 wież i wieżyczek, a do tego otacza ją sporych rozmiarów park, w którym odnajdziecie trzystuletnie okazy dębów.', 'Moszna', 'Zamkowa 1, 47-370', '50.440865356910560', '17.767794847181850', 1, 14),
(16, 'Fabryka Robotów Museum of scrap sculpture', 'FabrykaRobotowMuseumofscrapsculpture.jpg', 'To jedyne miejsce w Polsce a nawet w Europie gdzie budowane są ogromne stalowe roboty inspirowane filmami Sci-fi. Wszystkie postacie zostały zbudowane ręcznie przez jednego człowieka.', 'Moszna', 'Zamkowa 2, 47-370', '50.435072604123590', '17.767142137379570', 1, 15),
(17, 'Góra Świętej Anny', 'GoraSwietejAnny.jpg', 'Góra Świętej Anny najwyższe wzniesienie grzbietu Chełma na Wyżynie Śląskiej o wysokości 408 m n.p.m. w obrębie gminy Leśnica. Wysokość względna mierzona od dna doliny Odry wynosi około 220 m.\r\n', 'Leśnica', 'Klasztorna 6, 47-154', '50.457473477874956', '18.168958753795938', 1, 13),
(18, 'Zamek w Niemodlinie', 'ZamekwNiemodlinie.jpg', 'Zamek książęcy, zbudowany na początku XIV wieku, od roku 1314 do 1382 był rezydencją książąt niemodlińskich. W roku 1428 został zniszczony podczas wojen husyckich, spalony w roku 1552.', 'Niemodlin', 'Rynek 55, 49-100', '50.641989131458440', '17.623176004858628', 1, 14),
(19, 'Zamek w Dąbrowie', 'ZamekwDabrowie.jpg', 'Obecnych kształtów zamek nabrał w latach 1894 – 1897 – za panowania rodu Hochberów, książąt pszczyńskich. To oni nadali mu ogromnym nakładem finansowym neorenesansowy kształt.', 'Dąbrowa', 'Zamkowa 4, 49-120', '50.679904652431595', '17.747565496904862', 1, 14),
(20, 'Gród Rycerski', 'GrodRycerski.jpg', 'W Grodzie Rycerskim dowiemy się, jak wyglądało życie i praca średniowiecznego rycerza i przyjrzymy się pracy dawnych rzemieślników, np. garncarzom, płatnerzom czy kowalom.', 'Byczyna', 'Biskupice 58, 46-220', '51.085015678958390', '18.161612829447080', 1, 13),
(21, 'Piramida w Rożnowie', 'PiramidawRoznowie.jpg', 'Piramida w Rożnowie grobowiec piramidalny o wysokości dziewięciu metrów. Powstał dla rodu von Eben. Został zaprojektowany i zbudowany w 1780 roku przez Carla Gottharda Langhansa.', 'Rożnów', 'Rożnów 48, 46-262', '51.053537389334980', '18.142089910413080', 1, 13),
(22, 'JuraPark Krasiejów', 'JuraParkKrasiejow.jpg', 'Jurapark Krasiejów to największy tematyczny park w Europie, w którym możemy zobaczyć i dotknąć prehistoryczne dinozaury. Obowiązuje tu zasada nauki przez zabawę dla wszystkich, niezależnie od wieku.', 'Krasiejów', '1 Maja 10, 46-040', '50.662522198408770', '18.267586176025116', 1, 16),
(23, 'Muzeum Piastów Śląskich', 'MuzeumPiastowSlaskich.jpg', 'Zwiedzający mogą podziwiać dzieła sakralne warsztatów śląskich od gotyku po barok. Na szczególną uwagę zasługuje ekspozycja Michaela Leopolda Willmanna określanego mianem śląskiego Rembrandta.', 'Brzeg', 'plac Zamkowy 1, 49-300', '50.863938913726230', '17.466105782142270', 1, 2),
(27, 'Łowisko Pstrąg w Moszczance', 'LowiskoPstragwMoszczance.jpg', 'Obiekt położony w Górach Opawskich. Jego ofertę wzbogaca baza noclegowa, gdzie na szczególną uwagę zasługują gospodarstwa agroturystyczne, choćby \"Złoty Potok\" czy \"Końskie Zacisze\".', 'Moszczanka', 'Moszczanka 134, 48-200', '50.287062573701340', '17.477847877725598', 1, 17),
(28, 'Zalew Kluczbork', 'ZalewKluczbork.jpg', 'Zalew Kluczbork jest sztucznym jeziorem na rzece Stobrawie. Pełni on role retencyjne, a także rekreacyjne. Jego powierzchnia to około 60 hektarów, a pojemność to około 1.5 miliona m3.', 'Ligota Górna', 'Gliwicka, 46-325', '50.966849036196030', '18.249769995225293', 1, 10),
(29, 'Stumilowy Lasek', 'StumilowyLasek.jpg', 'Wśród atrakcji najmłodsi odkryją: bajkowe domki mieszkańców Lasku, Bajkową Trasę, domek Hobbita, wioskę Indian, statek piracki, kolorowe wózeczki, którymi można pojeździć po Lasku.', 'Żyrowa', 'Boczna 47, 47-330', '50.443239814907800', '18.126642147181954', 1, 3),
(30, 'Party Kajaki', 'PartyKajaki.jpg', 'Jeśli mamy ochotę na odrobinę szaleństwa to udział w takich rajdzie na trasie kajakowej jest najlepszym rozwiązaniem, zarówno dla dorosłych, jak i dla dzieci. Dzieci są szczególną grupą odbiorców.', 'Staniszcze Małe', 'Granica 6a, 47-113', '50.673009294162860', '18.278733245946768', 1, 18),
(32, 'Rejsy po Odrze Statek Opolanin', 'RejsypoOdrzeStatekOpolanin.jpg', 'Rejs trwa 45 minut i podczas podróży można zobaczyć wiele ciekawych zabytków Opola. Ze statku podziwiać można m.in. Opolską Wenecję, ratusz, katedrę, Wieżę Piastowską czy kościół Franciszkanów. ', 'Opole', 'Odrowążów, 46-020', '50.662871695644185', '17.915286620200877', 1, 18),
(33, 'Zaginione Miasto Rosenau', 'ZaginioneMiastoRosenau.jpg', 'Interaktywny Park Rozrywki i Edukacji to miejsce wypoczynku i zabawy dla każdego. Miejsce, w którym 4 żywioły: ziemia, woda, powietrze i ogień pozwalają w atmosferze poznać podstawowe prawa fizyki.', 'Jarnołtówek', 'Pokrzywna 76, 48-267', '50.287608462615430', '17.472652520187374', 1, 16),
(34, 'Szlak Miejski w Głuchołazach', 'SzlakMiejskiwGlucholazach.jpg', 'Blisko 8. kilometrowy Szlak Miejski prowadzący przez najbardziej charakterystyczne części miasta, m.in.: zabytkową starówkę z wczesnogotyckim portalem kościoła św. Wawrzyńca, wieżę Bramy Górnej.', 'Głuchołazy', 'plac Basztowy 4A, 48-340', '50.315502050000000', '17.383305744285000', 1, 13),
(36, 'Góry Opawskie', 'GoryOpawskie.jpg', 'Góry Opawskie to najbardziej na wschód wysunięte pasmo górskie Sudetów. Najwyższym szczytem całego pasma jest leżący po czeskiej stronie- Pricny Vrch 975 m n.p.m..', 'Głuchołazy', '48-340', '50.284092168366280', '17.449785296125960', 1, 19),
(37, 'Stobrawski Park Krajobrazowy', 'StobrawskiParkKrajobrazowy.jpg', 'Stobrawski Park Krajobrazowy zajmuje obszar 52 636 ha i należy do największych parków krajobrazowych w Polsce. Zasięgiem objmuje 12 gmin województwa opolskiego, z czego 5 należy do powiatu opolskiego.', 'Ładza', '45-269', '50.882918879916666', '17.875572626999720', 1, 3),
(38, 'Muzeum Gazownictwa', 'MuzeumGazownictwa.jpg', 'Muzeum zostało utworzone w byłej gazowni w listopadzie 1991 roku i stanowi jedyny w Polsce obiekt, gdzie w całości zachowały się urządzenia do produkcji gazu miejskiego.', 'Paczków', 'Pocztowa 6, 48-370', '50.466167126084060', '17.004056533688313', 1, 15),
(40, 'Zamek w Otmuchowie', 'ZamekwOtmuchowie.jpg', 'Zamek w Otmuchowie budowla wzniesiona w średniowieczu, rozbudowana w latach 1585–1596 w stylu renesansowym, przebudowana w XVII w. w stylu barokowym, rezydencja biskupów wrocławskich do 1810.', 'Otmuchów', 'Zamkowa 4, 48-385', '50.464046067556694', '17.171738776017868', 1, 14),
(41, 'Pałac w Kopicach', 'PalacwKopicach.jpg', 'Pałac w Kopicach został wzniesiony w 1783 roku w miejscu dawnej siedziby rycerskiej. W 1859 roku budowlę kupuje Hans Ulrich von Schaffgotsch z myślą stworzenia rezydencji dla swojej żony, Joanny.\r\nPał', 'Kopice', 'Kopice 47, 49-200', '50.646186139505450', '17.446657698749807', 1, 14),
(42, 'Pałac Biskupów Wrocławskich', 'PalacBiskupowWroclawskich.jpg', 'Zamek biskupów wrocławskich w Ujeździe – ruiny zamku leżącego w mieście Ujazd, w powiecie strzeleckim, w województwie opolskim. Zamek powstał w połowie XIII wieku, jako własność biskupów wrocławskich.', 'Ujazd', 'Matejki, 47-143', '50.390883166232350', '18.348959261556566', 1, 14),
(43, 'Gwarkowa Perć', 'GwarkowaPerc.jpg', 'Gwarkowa Perć to ściany wyrobiska górniczego po nieczynnym kamieniołomie o powierzchni liczące około 1 200 m² powstałej po eksploatacji łupków fyllitowych.', 'Głuchołazy', '48-340', '50.277819880026534', '17.449230760670485', 1, 19),
(47, 'dasgasdg', '', '', '', '', '50.756875471849200', '17.857589721679688', 1, 20),
(48, 'Testowe miejsce', '', '', '', '', '40.733730386116875', '-73.988113403320312', 1, 20);

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `filtr`
--
ALTER TABLE `filtr`
  ADD PRIMARY KEY (`Id_filtru`);

--
-- Indeksy dla tabeli `kraj`
--
ALTER TABLE `kraj`
  ADD PRIMARY KEY (`Id_kraju`);

--
-- Indeksy dla tabeli `miejsce`
--
ALTER TABLE `miejsce`
  ADD PRIMARY KEY (`Id_miejsca`),
  ADD KEY `FK_kraju` (`FK_id_kraju`),
  ADD KEY `FK_filtru` (`FK_id_filtru`);

--
-- AUTO_INCREMENT dla zrzuconych tabel
--

--
-- AUTO_INCREMENT dla tabeli `filtr`
--
ALTER TABLE `filtr`
  MODIFY `Id_filtru` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT dla tabeli `kraj`
--
ALTER TABLE `kraj`
  MODIFY `Id_kraju` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT dla tabeli `miejsce`
--
ALTER TABLE `miejsce`
  MODIFY `Id_miejsca` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- Ograniczenia dla zrzutów tabel
--

--
-- Ograniczenia dla tabeli `miejsce`
--
ALTER TABLE `miejsce`
  ADD CONSTRAINT `miejsce_ibfk_1` FOREIGN KEY (`FK_id_kraju`) REFERENCES `kraj` (`Id_kraju`),
  ADD CONSTRAINT `miejsce_ibfk_2` FOREIGN KEY (`FK_id_filtru`) REFERENCES `filtr` (`Id_filtru`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
