-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Хост: 127.0.0.1
-- Время создания: Окт 27 2017 г., 14:54
-- Версия сервера: 10.1.19-MariaDB
-- Версия PHP: 7.0.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `book_shop`
--

-- --------------------------------------------------------

--
-- Структура таблицы `author`
--

CREATE TABLE `author` (
  `id` int(11) NOT NULL,
  `name` varchar(15) NOT NULL,
  `surname` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `author`
--

INSERT INTO `author` (`id`, `name`, `surname`) VALUES
(1, 'Alexander', 'Grin'),
(2, 'Fedor', 'Dostoevsky'),
(3, 'Roger', ' Zelazny'),
(4, 'Patrick', 'Zuskind'),
(5, 'Franz', 'Kafka'),
(6, 'Sergey', 'Lukyanenko'),
(7, 'Nikolay', 'Nosov'),
(8, 'Ernest', 'Hemingway'),
(9, 'John', 'Tolkien'),
(10, 'Evgenidis', 'Jeffrey'),
(11, 'Vladimir ', 'Vasilyev'),
(12, 'Paul', ' Andersen'),
(13, 'Andrew', 'Norton'),
(19, 'name25', 'surname4');

-- --------------------------------------------------------

--
-- Структура таблицы `book`
--

CREATE TABLE `book` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `price` double DEFAULT NULL,
  `description` text,
  `discount` double NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `book`
--

INSERT INTO `book` (`id`, `name`, `price`, `description`, `discount`) VALUES
(1, 'Scarlet Sails', 135, '"Scarlet Sails" is a story-an extravaganza of Alexander Greene about unshakable faith and all-conquering, sublime dream, about what everyone can do for a close miracle.', 10),
(2, 'The Brothers Karamazov', 200.25, NULL, 5),
(3, 'Medium gender ', 450.8, NULL, 0),
(4, 'The Chronicles of Amber', 320.25, 'The Chronicles of Amber is a fantasy series of ten novels by the famous American science fiction writer Roger Zelazny. The series is divided into two volumes of five parts each, in the first volume the main character is Corwin, in the second - his son Merlin. In various translations of Amber (English amber - amber) is also called "Amber", "Amber", "Amber Kingdom"', 0),
(5, 'Perfumer', 400, '"The Story of a Murderer" tells about the life of a man whose "genius and phenomenal vanity was limited to a sphere that leaves no trace in history - a volatile kingdom of smells."', 0),
(6, 'Process', 305.25, NULL, 0),
(7, 'The night Watch\n', 375, 'The streets of the night city are dangerous - it is at this time for hunting sent by Others: vampires, magicians, werewolves and other evil spirits. They are more dangerous than the most cruel criminals. After all, coping with them is very difficult.', 5),
(8, 'The Living Hat', 205.25, 'The hat lay on the chest of drawers, the kitten Vaska sat on the floor near the chest of drawers, while Vovka and Vadik sat at the table and painted the pictures. What happened next ... read the book', 2.5),
(9, 'Car', 112, 'When Mishka and I were very young, we really wanted to go for a ride on a car, but it was not possible at all. No matter how much we asked the chauffeurs, no one wanted to roll us. Once we walked in the courtyard. Suddenly we look - in the street, near our gate, the car stopped.', 0),
(10, 'Star guard. Crusaders of the sky', 223.45, 'There is an ancient legend about the Roman emperor who, to show his power, summoned the commander of the faithful legion and told him to go with his people across Asia to the edge of the world. And then a thousand people disappeared on a huge continent, was swallowed by him forever. On some unknown battlefield, the last handful of survivors lined up in the square, defending themselves against the attack of the barbarians. And their eagle, perhaps a generation later, stood, lonely and shedding, in the tent of the leader of the nomads. But those who knew these proud people, their service and traditions, could assume that they continued to go to the east, while at least one remained on their feet. In 8054, from the birth of Christ, history repeated itself, as it always does. The first Galactic Empire collapsed. Dictators, emperors, unifiers have wrested from theirs the power of the Central Control their own and neighboring solar systems. Space emperors raised flags and exterminated fleets to absorb prey - the remnants of the collapse of the empire. At that time only ruthless flourished. Here and there a person or group of people tried in vain to resist the flow of destruction and separation. And among these fighters who refused to forget their faith in the indestructible rule of the Central Control, the most notable were the remnants of the Star Patrol, an armed association that for thousands of years enjoyed an indisputable authority. Perhaps, precisely because in their ranks they no longer found security. These people held on tightly to each other, adhered even more strictly to their ancient code of ethics and morality. And their stubborn loyalty to the disappeared ideals and irritated the new rulers, and caused them pity.', 0);

--
-- Триггеры `book`
--
DELIMITER $$
CREATE TRIGGER `clone_rec` BEFORE DELETE ON `book` FOR EACH ROW begin
	 insert into historybook(book_id, book_name, price) values (old.id, old.name, old.price);
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `book_author`
--

CREATE TABLE `book_author` (
  `book_id` int(11) NOT NULL,
  `author_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `book_author`
--

INSERT INTO `book_author` (`book_id`, `author_id`) VALUES
(2, 2),
(3, 10),
(4, 3),
(5, 4),
(6, 5),
(7, 6),
(7, 11),
(10, 12),
(10, 13),
(8, 7),
(9, 7);

-- --------------------------------------------------------

--
-- Структура таблицы `book_ganre`
--

CREATE TABLE `book_ganre` (
  `book_id` int(11) NOT NULL,
  `ganre_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `book_ganre`
--

INSERT INTO `book_ganre` (`book_id`, `ganre_id`) VALUES
(2, 7),
(2, 6),
(3, 6),
(2, 2),
(4, 8),
(6, 7),
(7, 8),
(8, 1),
(9, 1),
(8, 4),
(9, 4),
(10, 8);

-- --------------------------------------------------------

--
-- Структура таблицы `cart`
--

CREATE TABLE `cart` (
  `id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `book_id` int(11) NOT NULL,
  `count` smallint(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `cart`
--

INSERT INTO `cart` (`id`, `client_id`, `book_id`, `count`) VALUES
(32, 7, 1, 1),
(33, 7, 10, 2);

-- --------------------------------------------------------

--
-- Структура таблицы `client`
--

CREATE TABLE `client` (
  `id` int(11) NOT NULL,
  `name` varchar(15) DEFAULT NULL,
  `surname` varchar(30) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `login` varchar(20) NOT NULL,
  `password` varchar(32) NOT NULL,
  `discount` double NOT NULL DEFAULT '0',
  `disable` tinyint(1) NOT NULL DEFAULT '0',
  `status` varchar(32) NOT NULL,
  `time_life` int(11) NOT NULL,
  `is_admin` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `client`
--

INSERT INTO `client` (`id`, `name`, `surname`, `phone`, `email`, `login`, `password`, `discount`, `disable`, `status`, `time_life`, `is_admin`) VALUES
(1, 'test', 'stest', '2222222222', 'test@mail.ru', 'test123', '78ceb0db205009fe9b3a58f22a87ded4', 9, 0, '9ecc5c90e2c569263c0f4b6a9843f5af', 1509093648, 0),
(2, 'ww', 'ded', '1231231231', 'de@ef.hy', 'qqqqqq1', '8f49c75c8f95b446d576', 0, 0, 'a68cbc37a0c0ef4d228d4fe1c1166bef', 1508024478, 0),
(3, 'qq', 'qq', '1234567890', 'qq@qq.kl', 'ssssss', '810f651605cea4f0b86c', 0, 0, '77fa38be05b7ac3392886198abdd4a72', 1508024709, 0),
(4, 'q', 'q', '1234123411', 'q@q.yu', 'aaaaaa', 'f5b13b023f1bc64f82bf', 0, 0, '64634e57f02da43c35b39ca77ced3f6a', 1508029126, 0),
(5, 'q', 'q', '1231231231', 'qqq@q.qq', 'zzzzzz', 'c0abfc84e92a3c490e3cc812568d9560', 0, 0, '83b979b0446c542b43679b439f96a59f', 1508030386, 0),
(6, 's', 's', '1231231231', 'ss@ss.ru', 'xxxxxx', '4e52acf3b29d526b342da07f481d26bb', 0, 0, 'f7e6ee49d1d7dcfdc0f4f26d703d8669', 1509188143, 0),
(7, 'dd', 'dd', '1231231231', 'dd@dd.ru', 'dddddd', '5f4b1457753095bae20f050aa0694812', 0, 0, 'f2abccf77722a9048a1f3c3b7f02456b', 1508426044, 0),
(8, 'admin', 'admin', '1234567890', 'admin@gmail.com', 'sadmin', 'ef8dc897bb1f9ce6ca71146b085ab3e5', 0, 0, 'c78787d91153553711af86d03c0136a1', 1509189201, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `fullinfoorder`
--

CREATE TABLE `fullinfoorder` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `book_price` double NOT NULL,
  `book_id` int(11) NOT NULL,
  `count` smallint(6) NOT NULL,
  `discount_book` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `fullinfoorder`
--

INSERT INTO `fullinfoorder` (`id`, `order_id`, `book_price`, `book_id`, `count`, `discount_book`) VALUES
(14, 14, 205.25, 8, 1, 2.5),
(15, 14, 200.25, 2, 2, 5),
(16, 15, 320.25, 4, 1, 0),
(17, 15, 450.8, 3, 1, 0),
(18, 15, 135, 1, 1, 10),
(19, 16, 400, 5, 1, 0),
(20, 16, 135, 1, 4, 10),
(21, 18, 135, 1, 1, 10),
(23, 21, 135, 1, 1, 10);

-- --------------------------------------------------------

--
-- Структура таблицы `ganre`
--

CREATE TABLE `ganre` (
  `id` int(11) NOT NULL,
  `name` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `ganre`
--

INSERT INTO `ganre` (`id`, `name`) VALUES
(1, 'childrens'),
(2, 'classic'),
(3, 'adventure'),
(4, 'stories'),
(5, 'poetry'),
(6, 'works of fiction'),
(7, 'novel'),
(8, 'fantasy'),
(15, 'Ñ‹Ð²Ð°Ñ‹');

-- --------------------------------------------------------

--
-- Структура таблицы `historybook`
--

CREATE TABLE `historybook` (
  `book_id` int(11) NOT NULL,
  `book_name` varchar(100) NOT NULL,
  `price` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `historybook`
--

INSERT INTO `historybook` (`book_id`, `book_name`, `price`) VALUES
(11, 'adssds', 6),
(12, 'sfsgtrt', 0),
(13, 'safsdgfr', 0);

-- --------------------------------------------------------

--
-- Структура таблицы `order_book`
--

CREATE TABLE `order_book` (
  `id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `payment_id` tinyint(4) NOT NULL,
  `status_id` tinyint(4) NOT NULL,
  `discount_client` float NOT NULL DEFAULT '0',
  `date_order_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `total_price` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `order_book`
--

INSERT INTO `order_book` (`id`, `client_id`, `payment_id`, `status_id`, `discount_client`, `date_order_create`, `total_price`) VALUES
(14, 6, 5, 1, 0, '2017-10-20 11:35:07', 580.59),
(15, 6, 3, 1, 0, '2017-10-20 11:35:30', 892.55),
(16, 6, 2, 2, 0, '2017-10-22 02:37:33', 886),
(18, 6, 5, 1, 0, '2017-10-22 02:52:37', 121.5),
(20, 6, 5, 1, 0, '2017-10-22 02:58:28', 112),
(21, 6, 3, 1, 0, '2017-10-22 22:53:24', 121.5);

-- --------------------------------------------------------

--
-- Структура таблицы `payment`
--

CREATE TABLE `payment` (
  `id` tinyint(4) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `payment`
--

INSERT INTO `payment` (`id`, `name`) VALUES
(1, 'PayPal'),
(2, 'MasterCard'),
(3, 'LiqPay'),
(4, 'Qiwi'),
(5, 'WebMoney');

-- --------------------------------------------------------

--
-- Структура таблицы `statusorder`
--

CREATE TABLE `statusorder` (
  `id` tinyint(4) NOT NULL,
  `name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `statusorder`
--

INSERT INTO `statusorder` (`id`, `name`) VALUES
(1, 'in processing'),
(2, 'ready to ship'),
(3, 'send'),
(4, 'closed');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `author`
--
ALTER TABLE `author`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `book`
--
ALTER TABLE `book`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `book_author`
--
ALTER TABLE `book_author`
  ADD KEY `BookAuthor_fk0` (`book_id`),
  ADD KEY `BookAuthor_fk1` (`author_id`);

--
-- Индексы таблицы `book_ganre`
--
ALTER TABLE `book_ganre`
  ADD KEY `BookGanre_fk0` (`book_id`),
  ADD KEY `BookGanre_fk1` (`ganre_id`);

--
-- Индексы таблицы `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Bin_fk0` (`client_id`),
  ADD KEY `Bin_fk1` (`book_id`);

--
-- Индексы таблицы `client`
--
ALTER TABLE `client`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `login` (`login`);

--
-- Индексы таблицы `fullinfoorder`
--
ALTER TABLE `fullinfoorder`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FullInfoOrder_fk0` (`order_id`),
  ADD KEY `FullInfoOrder_fk1` (`book_id`);

--
-- Индексы таблицы `ganre`
--
ALTER TABLE `ganre`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `order_book`
--
ALTER TABLE `order_book`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Order_fk0` (`client_id`),
  ADD KEY `Order_fk1` (`payment_id`),
  ADD KEY `Order_fk2` (`status_id`);

--
-- Индексы таблицы `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `statusorder`
--
ALTER TABLE `statusorder`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `author`
--
ALTER TABLE `author`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;
--
-- AUTO_INCREMENT для таблицы `book`
--
ALTER TABLE `book`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT для таблицы `cart`
--
ALTER TABLE `cart`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;
--
-- AUTO_INCREMENT для таблицы `client`
--
ALTER TABLE `client`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT для таблицы `fullinfoorder`
--
ALTER TABLE `fullinfoorder`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;
--
-- AUTO_INCREMENT для таблицы `ganre`
--
ALTER TABLE `ganre`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
--
-- AUTO_INCREMENT для таблицы `order_book`
--
ALTER TABLE `order_book`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;
--
-- AUTO_INCREMENT для таблицы `payment`
--
ALTER TABLE `payment`
  MODIFY `id` tinyint(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT для таблицы `statusorder`
--
ALTER TABLE `statusorder`
  MODIFY `id` tinyint(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `book_author`
--
ALTER TABLE `book_author`
  ADD CONSTRAINT `BookAuthor_fk0` FOREIGN KEY (`book_id`) REFERENCES `book` (`id`),
  ADD CONSTRAINT `BookAuthor_fk1` FOREIGN KEY (`author_id`) REFERENCES `author` (`id`);

--
-- Ограничения внешнего ключа таблицы `book_ganre`
--
ALTER TABLE `book_ganre`
  ADD CONSTRAINT `BookGanre_fk0` FOREIGN KEY (`book_id`) REFERENCES `book` (`id`),
  ADD CONSTRAINT `BookGanre_fk1` FOREIGN KEY (`ganre_id`) REFERENCES `ganre` (`id`);

--
-- Ограничения внешнего ключа таблицы `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `Bin_fk0` FOREIGN KEY (`client_id`) REFERENCES `client` (`id`),
  ADD CONSTRAINT `Bin_fk1` FOREIGN KEY (`book_id`) REFERENCES `book` (`id`);

--
-- Ограничения внешнего ключа таблицы `fullinfoorder`
--
ALTER TABLE `fullinfoorder`
  ADD CONSTRAINT `FullInfoOrder_fk0` FOREIGN KEY (`order_id`) REFERENCES `order_book` (`id`),
  ADD CONSTRAINT `FullInfoOrder_fk1` FOREIGN KEY (`book_id`) REFERENCES `book` (`id`);

--
-- Ограничения внешнего ключа таблицы `order_book`
--
ALTER TABLE `order_book`
  ADD CONSTRAINT `Order_fk0` FOREIGN KEY (`client_id`) REFERENCES `client` (`id`),
  ADD CONSTRAINT `Order_fk1` FOREIGN KEY (`payment_id`) REFERENCES `payment` (`id`),
  ADD CONSTRAINT `Order_fk2` FOREIGN KEY (`status_id`) REFERENCES `statusorder` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
