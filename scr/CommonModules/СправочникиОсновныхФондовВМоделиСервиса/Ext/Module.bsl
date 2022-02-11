﻿////////////////////////////////////////////////////////////////////////////////
// Обработчики получения поставляемых данных.
//
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Регистрирует обработчики поставляемых данных за день и за все время
//
// Параметры: 
//   Обработчики - ТаблицаЗначений - таблица для добавления обработчиков с колонками:
//     * ВидДанных - Строка - код вида данных, обрабатываемый обработчиком.
//     * КодОбработчика - Строка - будет использоваться при восстановлении обработки данных после сбоя.
//     * Обработчик - ОбщийМодуль - модуль, содержащий следующие процедуры:
//          ДоступныНовыеДанные(Дескриптор, Загружать) Экспорт  
//          ОбработатьНовыеДанные(Дескриптор, ПутьКФайлу) Экспорт
//          ОбработкаДанныхОтменена(Дескриптор) Экспорт
//
Процедура ЗарегистрироватьОбработчикиПоставляемыхДанных(Знач Обработчики) Экспорт
	
	Обработчик = Обработчики.Добавить();
	Обработчик.ВидДанных = "СправочникЕНАОФ";
	Обработчик.КодОбработчика = "СправочникЕНАОФ";
	Обработчик.Обработчик = СправочникиОсновныхФондовВМоделиСервиса;
	
КонецПроцедуры

// Вызывается при получении уведомления о новых данных.
// В теле следует проверить, необходимы ли эти данные приложению, 
// и если да - установить флажок Загружать.
// 
// Параметры:
//   Дескриптор - ОбъектXDTO - Дескриптор.
//   Загружать - Булево - Возвращаемое.
//
Процедура ДоступныНовыеДанные(Знач Дескриптор, Загружать) Экспорт
	
	Если Дескриптор.DataType = "СправочникЕНАОФ" Тогда
		Загружать = Истина;
	КонецЕсли;
	
КонецПроцедуры

// Вызывается после вызова ДоступныНовыеДанные, позволяет разобрать данные.
//
// Параметры:
//   Дескриптор - ОбъектXDTO - Дескриптор.
//   ПутьКФайлу - Строка - Полное имя извлеченного файла, Файл будет автоматически удален после завершения процедуры.
//
Процедура ОбработатьНовыеДанные(Знач Дескриптор, Знач ПутьКФайлу) Экспорт
	
	Если Дескриптор.DataType = "СправочникЕНАОФ" Тогда
		ОбработатьЕНАОФ(Дескриптор, ПутьКФайлу);
	КонецЕсли;
	
КонецПроцедуры

// Вызывается при отмене обработки данных в случае сбоя
//
// Параметры:
//   Дескриптор - ОбъектXDTO - Дескриптор.
//
Процедура ОбработкаДанныхОтменена(Знач Дескриптор) Экспорт 
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ОбработатьЕНАОФ(Знач Дескриптор, Знач ПутьКФайлу)
	
	ТаблицаЭлементов = ПостроитьТаблицуЭлементов(ПутьКФайлу);
	
	Для каждого СтрокаЭлемента Из ТаблицаЭлементов Цикл
		
		Если ЗначениеЗаполнено(СтрокаЭлемента.КодРодителя) Тогда
			Если НЕ СтрокаЭлемента.РодительЭтоГруппа Тогда
				ШаблонСообщения = НСтр("ru = 'Невозможно создать / обновить элемент с кодом %1 т.к. в качестве родителя у него указан элемент (%2)'");
				ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(ШаблонСообщения, СтрокаЭлемента.Код,
					СтрокаЭлемента.КодРодителя);
				ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения);
				Продолжить;
			КонецЕсли;
			
			// Родитель не существовал до загрузки
			Если СтрокаЭлемента.Родитель = NULL Тогда
				Родитель = Справочники.ЕдиныеНормыАмортизационныхОтчисленийОсновныхФондов.НайтиПоКоду(СтрокаЭлемента.КодРодителя);
				СтрокиСТакимЖеРодителем = ТаблицаЭлементов.НайтиСтроки(Новый Структура("КодРодителя", СтрокаЭлемента.КодРодителя));
				Для Каждого СтрокаСРодителем Из СтрокиСТакимЖеРодителем Цикл
					СтрокаСРодителем.Родитель = Родитель;
				КонецЦикла;
			Иначе
				Родитель = СтрокаЭлемента.Родитель;
			КонецЕсли;
			
			Если НЕ ЗначениеЗаполнено(Родитель) Тогда
				// При загрузке родителя произошла ошибка
				Продолжить;
			КонецЕсли;
		Иначе
			Родитель = Неопределено;
		КонецЕсли;
		
		Объект = Неопределено;
		Ссылка = СтрокаЭлемента.Ссылка;
		Если Ссылка.Пустая() Тогда 
			Если СтрокаЭлемента.ЭтоГруппа Тогда
				Объект = Справочники.ЕдиныеНормыАмортизационныхОтчисленийОсновныхФондов.СоздатьГруппу();
			Иначе
				Объект = Справочники.ЕдиныеНормыАмортизационныхОтчисленийОсновныхФондов.СоздатьЭлемент();
			КонецЕсли;
			Объект.Код = СтрокаЭлемента.Код;
		ИначеЕсли СтрокаЭлемента.СсылкаЭтоГруппа = СтрокаЭлемента.ЭтоГруппа Тогда
			Объект = Ссылка.ПолучитьОбъект();
		Иначе
			ШаблонСообщения = НСтр("ru = 'Элемент с кодом %1 невозможно обновить'");
			ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(ШаблонСообщения, СтрокаЭлемента.Код);
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения);
			Продолжить;
		КонецЕсли;
		
		Если Объект <> Неопределено Тогда
			Объект.Родитель = Родитель;
			Объект.Наименование = СтрокаЭлемента.Наименование;
			Если НЕ СтрокаЭлемента.ЭтоГруппа Тогда
				Объект.НормаАмортизационныхОтчислений = СтрокаЭлемента.НормаАмортизационныхОтчислений;
				Объект.ПроцентОтСтоимостиМашины = СтрокаЭлемента.ПроцентОтСтоимостиМашины;
			КонецЕсли;
			
			Попытка
				Объект.Записать();
			Исключение
				ШаблонСообщения = НСтр("ru = 'Ошибка при записи элемента с кодом %1
				                             |%2'");
				ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(ШаблонСообщения, Объект.Код,
					ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
				ЗаписьЖурналаРегистрации(НСтр("ru = 'Загрузка классификатора'", ОбщегоНазначения.КодОсновногоЯзыка()), 
					УровеньЖурналаРегистрации.Ошибка,,, ТекстСообщения);
			КонецПопытки;
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

Процедура ЗагрузитьЕНАОФИзФайла(Знач ПутьКФайлу, Знач ТаблицаЭлементов)
	
	ФайлЧтение = Новый ЧтениеXML;
	
	ФайлЧтение.ОткрытьФайл(ПутьКФайлу);
	ФайлЧтение.Прочитать();
	ФайлЧтение.Прочитать();

	ИмяТипаXML = "CatalogObject.ЕдиныеНормыАмортизационныхОтчисленийОсновныхФондов";
	ТипСсылки = Тип("Строка");
	Пока ВозможностьЧтенияXML(ФайлЧтение) Цикл
		ТипXML = ПолучитьXMLТип(ФайлЧтение);
		Если ТипXML.ИмяТипа = ИмяТипаXML Тогда
			// Чтение следующего узла
			ФайлЧтение.Прочитать();
			НоваяСтрока = ТаблицаЭлементов.Добавить();
			НоваяСтрока.Ссылка = ПрочитатьXML(ФайлЧтение, Тип("УникальныйИдентификатор"));
			НоваяСтрока.ЭтоГруппа = ПрочитатьXML(ФайлЧтение, Тип("Булево"));
			ПрочитатьXML(ФайлЧтение, Тип("Булево")); // ПометкаУдаления
			НоваяСтрока.СсылкаРодителя = ПрочитатьXML(ФайлЧтение, Тип("УникальныйИдентификатор"));
			Код = ПрочитатьXML(ФайлЧтение, Тип("Число"));
			НоваяСтрока.Код = Лев(Формат(Код, "ЧЦ=9") + "         ", 9);
			НоваяСтрока.Наименование = ПрочитатьXML(ФайлЧтение, Тип("Строка"));
			Если НЕ НоваяСтрока.ЭтоГруппа Тогда
				НоваяСтрока.НормаАмортизационныхОтчислений = ПрочитатьXML(ФайлЧтение, Тип("Число"));
				НоваяСтрока.ПроцентОтСтоимостиМашины = ПрочитатьXML(ФайлЧтение, Тип("Число"));
			КонецЕсли;
	
			// Проверяем, что текущим узлом является КонецЭлемента
			Если ФайлЧтение.ТипУзла <> ТипУзлаXML.КонецЭлемента Тогда
				ТекстСообщения = НСтр("ru = 'Ошибка чтения XML'");
				ВызватьИсключение ТекстСообщения;
			КонецЕсли;
			// Чтение следующего узла для завершение чтения элемента
			ФайлЧтение.Прочитать();
		Иначе
			ВызватьИсключение НСтр("ru = 'Файл данных не является справочником ЕНАОФ'");
		КонецЕсли;
	КонецЦикла;
	ТаблицаЭлементов.Индексы.Добавить("Ссылка");
	Для каждого Строка Из ТаблицаЭлементов Цикл
		Если ЗначениеЗаполнено(Строка.СсылкаРодителя) Тогда
			Родители = ТаблицаЭлементов.НайтиСтроки(Новый Структура("Ссылка", Строка.СсылкаРодителя));
			Если Родители.Количество() = 0 Тогда
				ВызватьИсключение НСтр("ru = 'Некорректный файл - невозможно найти родителя с ссылкой %1'");
			КонецЕсли;
			Строка.КодРодителя = Родители[0].Код;
			Строка.СтрокаРодителя = Родители[0];
		Иначе
			Строка.Поколение = 1;
		КонецЕсли;
	КонецЦикла;
	
	Продолжать = Истина;
	Пока Продолжать Цикл
		Продолжать = Ложь;
		Для каждого Строка Из ТаблицаЭлементов Цикл
			Если Строка.Поколение = 0 Тогда
				Если Строка.СтрокаРодителя.Поколение <> 0 Тогда
					Строка.Поколение = Строка.СтрокаРодителя.Поколение + 1;
				Иначе
					Продолжать = Истина;
				КонецЕсли;
			КонецЕсли;
		КонецЦикла;
	КонецЦикла;

КонецПроцедуры

Функция ПостроитьТаблицуЭлементов(Знач ПутьКФайлу)
	
	ТаблицаЭлементов = Новый ТаблицаЗначений;
	
	ТаблицаЭлементов.Колонки.Добавить("Ссылка", Новый ОписаниеТипов("УникальныйИдентификатор"));
	ТаблицаЭлементов.Колонки.Добавить("СсылкаРодителя", Новый ОписаниеТипов("УникальныйИдентификатор"));
	ТаблицаЭлементов.Колонки.Добавить("СтрокаРодителя", Новый ОписаниеТипов("СтрокаТаблицыЗначений"));
	ТаблицаЭлементов.Колонки.Добавить("Код", ОбщегоНазначения.ОписаниеТипаСтрока(9));
	ТаблицаЭлементов.Колонки.Добавить("ЭтоГруппа", Новый ОписаниеТипов("Булево"));
	ТаблицаЭлементов.Колонки.Добавить("Наименование", ОбщегоНазначения.ОписаниеТипаСтрока(100));
	ТаблицаЭлементов.Колонки.Добавить("КодРодителя", ОбщегоНазначения.ОписаниеТипаСтрока(9));
	ТаблицаЭлементов.Колонки.Добавить("Поколение", ОбщегоНазначения.ОписаниеТипаЧисло(10, 0));
	ТаблицаЭлементов.Колонки.Добавить("НормаАмортизационныхОтчислений", ОбщегоНазначения.ОписаниеТипаЧисло(4, 2));
	ТаблицаЭлементов.Колонки.Добавить("ПроцентОтСтоимостиМашины", ОбщегоНазначения.ОписаниеТипаЧисло(4, 2));
	
	ЗагрузитьЕНАОФИзФайла(ПутьКФайлу, ТаблицаЭлементов);
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("ТаблицаЭлементов", ТаблицаЭлементов);
	Запрос.Текст =
	"ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	ТаблицаЭлементов.Код КАК Код,
	|	ТаблицаЭлементов.ЭтоГруппа КАК ЭтоГруппа,
	|	ТаблицаЭлементов.Наименование КАК Наименование,
	|	ТаблицаЭлементов.КодРодителя КАК КодРодителя,
	|	ТаблицаЭлементов.Поколение КАК Поколение,
	|	ТаблицаЭлементов.НормаАмортизационныхОтчислений КАК НормаАмортизационныхОтчислений,
	|	ТаблицаЭлементов.ПроцентОтСтоимостиМашины КАК ПроцентОтСтоимостиМашины
	|ПОМЕСТИТЬ ТаблицаЭлементов
	|ИЗ
	|	&ТаблицаЭлементов КАК ТаблицаЭлементов
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	Код
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	ТаблицаЭлементов.Код КАК Код,
	|	ТаблицаЭлементов.ЭтоГруппа КАК ЭтоГруппа,
	|	ТаблицаЭлементов.Наименование КАК Наименование,
	|	ТаблицаЭлементов.КодРодителя КАК КодРодителя,
	|	ТаблицаЭлементов.Поколение КАК Поколение,
	|	КлассификаторРодители.Ссылка КАК Родитель,
	|	ЕСТЬNULL(КлассификаторРодители.ЭтоГруппа, ТаблицаРодителей.ЭтоГруппа) КАК РодительЭтоГруппа,
	|	ЕСТЬNULL(Классификатор.Ссылка, ЗНАЧЕНИЕ(Справочник.ЕдиныеНормыАмортизационныхОтчисленийОсновныхФондов.ПустаяСсылка)) КАК Ссылка,
	|	Классификатор.ЭтоГруппа КАК СсылкаЭтоГруппа,
	|	ТаблицаЭлементов.НормаАмортизационныхОтчислений КАК НормаАмортизационныхОтчислений,
	|	ТаблицаЭлементов.ПроцентОтСтоимостиМашины КАК ПроцентОтСтоимостиМашины
	|ИЗ
	|	ТаблицаЭлементов КАК ТаблицаЭлементов
	|		ЛЕВОЕ СОЕДИНЕНИЕ ТаблицаЭлементов КАК ТаблицаРодителей
	|		ПО ТаблицаЭлементов.КодРодителя = ТаблицаРодителей.Код
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.ЕдиныеНормыАмортизационныхОтчисленийОсновныхФондов КАК КлассификаторРодители
	|		ПО ТаблицаЭлементов.КодРодителя = КлассификаторРодители.Код
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.ЕдиныеНормыАмортизационныхОтчисленийОсновныхФондов КАК Классификатор
	|		ПО ТаблицаЭлементов.Код = Классификатор.Код
	|
	|УПОРЯДОЧИТЬ ПО
	|	ТаблицаЭлементов.Поколение,
	|	ТаблицаЭлементов.Код";
	ТаблицаЭлементов = Запрос.Выполнить().Выгрузить();
	ТаблицаЭлементов.Индексы.Добавить("КодРодителя");
		
	Возврат ТаблицаЭлементов;
	
КонецФункции

#КонецОбласти