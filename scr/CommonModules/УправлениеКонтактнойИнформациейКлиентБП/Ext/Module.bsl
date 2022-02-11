﻿////////////////////////////////////////////////////////////////////////////////
// Подсистема "Контактная информация Бухгалтерии предприятия".
//
////////////////////////////////////////////////////////////////////////////////

#Область СлужебныйПрограммныйИнтерфейс

Процедура ПоказатьНаКартеНажатие(Форма, Элемент, Знач Адрес, ДополнениеАдреса = "") Экспорт
	
	СписокСервисовКартографии = Новый СписокЗначений;
	СписокСервисовКартографии.Добавить("ЯндексКарты", "Яндекс.Карты");
	СписокСервисовКартографии.Добавить("GoogleMaps", "Google Карты");
	
	Адрес = СокрЛП(ДополнениеАдреса + " " + АдресБезИндекса(Адрес));
	
	ПараметрыОповещения = Новый Структура();
	ПараметрыОповещения.Вставить("Адрес", Адрес);
	
	ПараметрыОповещения.Вставить("Объект", ИмяОбъектаФормы(Форма));
	
	Оповещение = Новый ОписаниеОповещения("ПоказатьНаКартеНажатиеЗавершение", ЭтотОбъект, ПараметрыОповещения);
	
	Форма.ПоказатьВыборИзМеню(Оповещение, СписокСервисовКартографии, Элемент);

КонецПроцедуры

Процедура ПоказатьНаКартеНажатиеЗавершение(ИмяКартографическогоСервиса, ДополнительныеПараметры) Экспорт
	
	Если ТипЗнч(ИмяКартографическогоСервиса) = Тип("ЭлементСпискаЗначений") И ДополнительныеПараметры.Свойство("Адрес") Тогда
		
		УправлениеКонтактнойИнформациейКлиент.ПоказатьАдресНаКарте(
			ДополнительныеПараметры.Адрес, 
			ИмяКартографическогоСервиса.Значение);
		
		Комментарий = СтрШаблон(
			НСтр("ru = 'Объект: %1 Сервис: %2'"),
			ДополнительныеПараметры.Объект,
			ИмяКартографическогоСервиса.Представление);
			
		ЖурналРегистрацииКлиент.ДобавитьСообщениеДляЖурналаРегистрации(
			НСтр("ru = 'Переход на карту'"),
			"Информация", Комментарий,
			,
			Истина);
		
	КонецЕсли;
	
КонецПроцедуры

#Область ИсторияКонтактнойИнформации

Процедура ИсторияИзмененийАдресаНажатие(Форма, ВидКИ) Экспорт
	
	Элементы = Форма.Элементы;
	Объект = Форма.Объект;
	
	ОтборКИ = Новый Структура("Вид", ВидКИ);
	СтрокиКИ = Форма.КонтактнаяИнформацияОписаниеДополнительныхРеквизитов.НайтиСтроки(ОтборКИ);
	Если СтрокиКИ.Количество() = 0 Тогда
		ТекущийАдрес = Неопределено;
	Иначе
		ТекущийАдрес = Новый Структура("Значение, Представление",
			СтрокиКИ[0].Значение, СтрокиКИ[0].Представление);
	КонецЕсли;
	
	ПараметрыФормы = Новый Структура("Вид, ТекущийАдрес, ИсторияИзмененийАдреса, ТолькоПросмотр",
		ВидКИ,
		ТекущийАдрес,
		Объект.ИсторияКонтактнойИнформации,
		Форма.ТолькоПросмотр);
	
	ОткрытьФорму("ОбщаяФорма.РедактированиеИсторииКонтактнойИнформации", ПараметрыФормы, Форма);

КонецПроцедуры

Процедура УстановитьАдресПослеРедактированияИстории(Форма, НаборЗаписей, Элемент) Экспорт
	
	Элементы = Форма.Элементы;
	Объект = Форма.Объект;
	Форма.Модифицированность = Истина;
	
	НаборЗаписей.Сортировать("Период");
	
	Объект.ИсторияКонтактнойИнформации.Очистить();
	Если НаборЗаписей.Количество() > 1 Тогда
		Для Каждого ЗаписьНабора Из НаборЗаписей Цикл
			ЗаписьИстории = Объект.ИсторияКонтактнойИнформации.Добавить();
			ЗаполнитьЗначенияСвойств(ЗаписьИстории, ЗаписьНабора);
		КонецЦикла;
	КонецЕсли;
	
	СтрокаАдреса = НаборЗаписей[НаборЗаписей.Количество()-1];
	ОтборКИ = Новый Структура("ИмяРеквизита", Элемент.Имя);
	СтрокиКИ = Форма.КонтактнаяИнформацияОписаниеДополнительныхРеквизитов.НайтиСтроки(ОтборКИ);
	Если СтрокиКИ.Количество() = 0 Тогда
		СтрокаКИ = Форма.КонтактнаяИнформацияОписаниеДополнительныхРеквизитов.Добавить();
		СтрокаКИ.Тип = ПредопределенноеЗначение("Перечисление.ТипыКонтактнойИнформации.Адрес");
		СтрокаКИ.ИмяРеквизита = Элемент.Имя;
		СтрокаКИ.ИмяЭлементаДляРазмещения = "ГруппаКомпоновкиКонтактнойИнформации";
	Иначе
		СтрокаКИ = СтрокиКИ[0];
	КонецЕсли;
	ЗаполнитьЗначенияСвойств(СтрокаКИ, СтрокаАдреса);
	Форма[Элемент.Имя] = СтрокаАдреса.Представление;
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ИмяОбъектаФормы(Форма)
	
	Перем ИмяОбъекта, ИмяФормыПоСловам;
	
	ИмяФормыПоСловам = СтрРазделить(Форма.ИмяФормы, ".");
	
	Пока ИмяФормыПоСловам.ВГраница() > 1 Цикл
		ИмяФормыПоСловам.Удалить(ИмяФормыПоСловам.ВГраница());
	КонецЦикла;
	
	Возврат СтрСоединить(ИмяФормыПоСловам, ".");

КонецФункции

Функция АдресБезИндекса(Адрес)
	
	// Если индекс стоит вначале, то Google Карты не находят такой адрес.
	// Для правильного поиска уберем индекс из строки адреса.
	
	МассивЭлементовАдреса = СтрРазделить(Адрес, ",");
	Если МассивЭлементовАдреса.Количество() < 1 Тогда
		// Слишком мало элементов, с большой вероятностью индекса в адресе нет.
		Возврат Адрес;
	КонецЕсли;
	
	Индекс = СокрЛП(МассивЭлементовАдреса[0]);
	
	Если НЕ (СтроковыеФункцииКлиентСервер.ТолькоЦифрыВСтроке(Индекс) И СтрДлина(Индекс) = 6) Тогда
		// Это не индекс.
		Возврат Адрес;
	КонецЕсли;
	
	// Удалим индекс.
	МассивЭлементовАдреса.Удалить(0);
	
	// Формируем новую строку адреса.
	Возврат СокрЛП(СтрСоединить(МассивЭлементовАдреса, ","));
	
КонецФункции

#КонецОбласти