﻿#Область СлужебныеПроцедурыИФункции

// Возвращает все счета, где присутствует субконто Банковские счета
//
// Параметры:
//
// Возвращаемое значение:
//	СписокСчетов - Массив - массив счетов
//
Функция ПолучитьСчетаССубконтоБанковскиеСчета() Экспорт
	
	СписокСчетов = Новый Массив;
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	ХозрасчетныйВидыСубконто.Ссылка КАК Ссылка
	|ИЗ
	|	ПланСчетов.Хозрасчетный.ВидыСубконто КАК ХозрасчетныйВидыСубконто
	|ГДЕ
	|	ХозрасчетныйВидыСубконто.ВидСубконто = ЗНАЧЕНИЕ(ПланВидовХарактеристик.ВидыСубконтоХозрасчетные.БанковскиеСчета)
	|
	|УПОРЯДОЧИТЬ ПО
	|	Ссылка";
	
	Результат = Запрос.Выполнить();
	
	Если НЕ Результат.Пустой() Тогда
		СписокСчетов = Результат.Выгрузить().ВыгрузитьКолонку("Ссылка");
	КонецЕсли;
	
	Возврат Новый ФиксированныйМассив(СписокСчетов);
	
КонецФункции

Функция ПолучитьСтатьюДДСПоВидуОперации(ВидОперации) Экспорт
	
	Возврат Справочники.СтатьиДвиженияДенежныхСредств.ПолучитьСтатьюДДСПоВидуОперации(ВидОперации);
	
КонецФункции

Функция ПредопределеннаяСтатьяДДСПоКонтексту(ВидОперации) Экспорт
	
	Возврат Справочники.СтатьиДвиженияДенежныхСредств.ПредопределеннаяСтатьяДДСПоКонтексту(ВидОперации);
	
КонецФункции

#КонецОбласти
