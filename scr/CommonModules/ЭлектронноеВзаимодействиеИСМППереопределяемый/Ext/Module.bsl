#Область ПрограммныйИнтерфейс

// (См. ЭлектронноеВзаимодействиеМОТП.ЗаполнитьСведенияОМаркировке)
//   Переопределяет заполнение сведений о маркировке. Установить СтандартнаяОбработка=Ложь для переопределенных вызовов.
// 
Процедура ЗаполнитьСведенияОМаркировке(Приемник, Источник, ДанныеШтрихкодовУпаковок, СтандартнаяОбработка) Экспорт
	
	СтандартнаяОбработка = Ложь;
	
	Если ДанныеШтрихкодовУпаковок = Неопределено
		Или ДанныеШтрихкодовУпаковок.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	ПутьКДаннымДляОшибки = "Объект";
	
	ТаблицаКодов = Новый ТаблицаЗначений;
	ТаблицаКодов.Колонки.Добавить("Код");
	
	СведенияОМаркировке = Новый Структура;
	СведенияОМаркировке.Вставить("ИндивидуальныеУпаковки", ТаблицаКодов);
	Приемник.СведенияОМаркировке = СведенияОМаркировке;
	
	ПараметрыПоиска = Новый Структура("Номенклатура, Обработан");
	ПараметрыПоиска.Номенклатура = Источник.Товар;
	ПараметрыПоиска.Обработан    = Ложь;
	СтрокиУпаковок = ДанныеШтрихкодовУпаковок.НайтиСтроки(ПараметрыПоиска);
	Количество = Источник.Количество;
	Для Каждого СтрокаУпаковки Из СтрокиУпаковок Цикл
		Если (Количество<=0) Тогда
			Прервать;
		КонецЕсли;
		НоваяСтрока = ТаблицаКодов.Добавить();
		НоваяСтрока.Код = СтрокаУпаковки.ЗначениеШтрихКода;
		СтрокаУпаковки.Обработан = Истина;
		Количество = Количество - 1;
	КонецЦикла;
	
КонецПроцедуры

Процедура ПроверитьМаркируемуюПродукциюДокумента(Ссылка, Отказ) Экспорт
	
	Возврат;
	
КонецПроцедуры

// (См. ЭлектронноеВзаимодействиеМОТП.ЗаполнитьСведенияОМаркировке_2019)
// Переопределяет заполнение сведений о маркировке. Установить СтандартнаяОбработка=Ложь для переопределенных вызовов.
Процедура ЗаполнитьСведенияОМаркировке_2019(Приемник, Источник, ДанныеШтрихкодовУпаковок, СтандартнаяОбработка) Экспорт
	
	СтандартнаяОбработка = Ложь;
	
	Если ДанныеШтрихкодовУпаковок = Неопределено
		Или ДанныеШтрихкодовУпаковок.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	ПутьКДаннымДляОшибки = "Объект";
	
	ТаблицаКодов = Новый ТаблицаЗначений;
	ТаблицаКодов.Колонки.Добавить("Код");
	
	СведенияОМаркировке = Новый Структура;
	СведенияОМаркировке.Вставить("ИндивидуальныеУпаковки", ТаблицаКодов);
	Приемник.СведенияОМаркировке = СведенияОМаркировке;
	
	ПараметрыПоиска = Новый Структура("Номенклатура, Обработан");
	ПараметрыПоиска.Номенклатура = Источник.Товар;
	ПараметрыПоиска.Обработан    = Ложь;
	СтрокиУпаковок = ДанныеШтрихкодовУпаковок.НайтиСтроки(ПараметрыПоиска);
	Количество = Источник.Количество;
	Для Каждого СтрокаУпаковки Из СтрокиУпаковок Цикл
		Если (Количество<=0) Тогда
			Прервать;
		КонецЕсли;
		НоваяСтрока = ТаблицаКодов.Добавить();
		НоваяСтрока.Код = СтрокаУпаковки.ЗначениеШтрихКода;
		СтрокаУпаковки.Обработан = Истина;
		Количество = Количество - 1;
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

// Процедуры и функции для работы с другими версиями БЭД
//
#Область СлужебныйПрограммныйИнтерфейс

// Предназначена для получения значения из дерева значений по полному пути.
// (См. ЭлектронноеВзаимодействие.ЗначениеРеквизитаВДереве)
//
// Параметры:
//  ЗначениеРеквизита    - Произвольный   - найденное значения.
//  ДеревоДанных         - ДеревоЗначений - объект поиска.
//  ПолныйПуть           - Строка         - значение поиска.
//  СтандартнаяОбработка - Булево         - признак стандартной обработки (установить Ложь для переопределенных)
// 
Процедура ПриОпределенииЗначенияРеквизитаВДереве(ЗначениеРеквизита, ДеревоДанных, ПолныйПуть, СтандартнаяОбработка) Экспорт
	
	Возврат;
	
КонецПроцедуры

#КонецОбласти
