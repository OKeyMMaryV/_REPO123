﻿#Область ПрограммныйИнтерфейс

// Обрабатывает клик по навигационной ссылке на баннере.
//
// Параметры:
//  Форма				  - УправляемаяФорма - Форма, на которую выводится баннер.
//  НавигационнаяСсылка   - Строка - Навигационная ссылка баннера, по которой кликнул пользователь.
//  СтандартнаяОбработка  - Булеов - Признак стандартной обработки.
//
Процедура ОбработкаНавигационнойСсылкиБаннера(Форма, НавигационнаяСсылка, СтандартнаяОбработка) Экспорт
	
	Если НавигационнаяСсылка = "ОткрытьЖурналРегистрацииСОшибками" Тогда
		
		СтандартнаяОбработка = Ложь;
		
		ПараметрыОткрытия = Новый Структура("СобытиеЖурналаРегистрации",
			ИнтеграцияСБанкамиКлиентСервер.ИмяСобытияЖурналаРегистрации());
		ОткрытьФорму("Обработка.ЖурналРегистрации.Форма.ЖурналРегистрации", ПараметрыОткрытия, ЭтотОбъект);
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
