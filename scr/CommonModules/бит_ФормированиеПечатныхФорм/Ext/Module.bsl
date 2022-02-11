﻿
#Область СлужебныйПрограммныйИнтерфейс

#Область ИнтерфейсыКМетодамТиповыхКонфигураций

// Возвращает структуру данных со сводным описанием контрагента.
// 
// Параметры: 
//  СписокСведений - список значений со значениями параметров организации
//   СписокСведений формируется функцией СведенияОЮрФизЛице.
//  Список         - список запрашиваемых параметров организации.
//  СПрефиксом     - Признак выводить или нет префикс параметра организации.
// 
// Возвращаемое значение:
//  Строка - описатель организации / контрагента / физ.лица.
// 
Функция ОписаниеОрганизации(СписокСведений, Список = "", СПрефиксом = Истина) Экспорт

	Результат = Неопределено;
	
	Если бит_ОбщегоНазначения.ЭтоСемействоБП() Тогда   		
		
		Модуль = ОбщегоНазначения.ОбщийМодуль("ОбщегоНазначенияБПВызовСервера");
		Результат = Модуль.ОписаниеОрганизации(СписокСведений, Список, СПрефиксом);                
		
	ИначеЕсли бит_ОбщегоНазначения.ЭтоСемействоERP() Тогда
		
		Модуль = ОбщегоНазначения.ОбщийМодуль("ФормированиеПечатныхФорм");
		Результат = Модуль.ОписаниеОрганизации(СписокСведений, Список, СПрефиксом);                
		
	КонецЕсли;                
	
	Возврат Результат;

КонецФункции // ОписаниеОрганизации()

// Проверяет, умещаются ли переданные табличные документы на страницу при печати.
// 
// Параметры
//  ТабДокумент       - Табличный документ.
//  ВыводимыеОбласти  - Массив из проверяемых таблиц или табличный документ.
//  РезультатПриОшибке - Какой возвращать результат при возникновении ошибки.
// 
// Возвращаемое значение:
//   Булево   - умещаются или нет переданные документы.
// 
Функция ПроверитьВыводТабличногоДокумента(ТабДокумент, ВыводимыеОбласти, РезультатПриОшибке = Истина) Экспорт

	Попытка
		Возврат ТабДокумент.ПроверитьВывод(ВыводимыеОбласти);
	Исключение
		Возврат РезультатПриОшибке;
	КонецПопытки;

КонецФункции // ПроверитьВыводТабличногоДокумента()

// Формирует значения по умолчанию реквизитов плательщика и получателя для банковских платежных документов.
// 
// Параметры
//  Плательщик  		- <СправочникСсылка.Организации>/<СправочникСсылка.Контрагенты> 
// 								- плательщик, владелец банковского счета.
//  СчетПлательщика		- <СправочникСсылка.БанковскиеСчета> - банковский счет плательщика
//  Получатель  		- <СправочникСсылка.Организации>/<СправочникСсылка.Контрагенты> 
// 								- получатель, владелец банковского счета.
//  СчетПолучателя		- <СправочникСсылка.БанковскиеСчета> - банковский счет получателя.
//  ПеречислениеВБюджет	- <Булево> - флаг перечисления в бюджет.
// 
// Возвращаемое значение:
//   <Структура>		- структура строковых реквизитов плательщика и получателя
// 						  ключи структуры: 
// 							ТекстПлательщика, ИННПлательщика, КПППлательщика, 
// 							ТекстПолучателя, ИННПолучателя, КПППолучателя
// 							НаименованиеБанкаПлательщика, НомерСчетаПлательщика,
// 							БикБанкаПлательщика, СчетБанкаПлательщика 
// 							НаименованиеБанкаПолучателя, НомерСчетаПолучателя,
// 							БикБанкаПолучателя, СчетБанкаПолучателя.
// 
Функция СформироватьАвтоЗначенияРеквизитовПлательщикаПолучателя(Плательщик, СчетПлательщика, Получатель, 
			СчетПолучателя, ВидОперации = Неопределено, ПеречислениеВБюджет = Ложь) Экспорт
	
	Реквизиты = Новый Структура;
	Реквизиты.Вставить("ТекстПлательщика","");
	Реквизиты.Вставить("ТекстПолучателя","");
	Реквизиты.Вставить("ИННПолучателя","");
	Реквизиты.Вставить("КПППолучателя","");
	Реквизиты.Вставить("ИННПлательщика","");
	Реквизиты.Вставить("КПППлательщика","");
	
    Если бит_ОбщегоНазначения.ЭтоСемействоБП() Тогда
		ИндивидуальныйПредприниматель = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Плательщик, 
											"ИндивидуальныйПредприниматель");
		Период = Неопределено;
		Если ИндивидуальныйПредприниматель = Истина Тогда
			Период = ТекущаяДатаСеанса();
		КонецЕсли; 
    	Модуль 	  = ОбщегоНазначения.ОбщийМодуль("УчетДенежныхСредствБП");
    	Реквизиты = Модуль.СформироватьАвтоЗначенияРеквизитовПлательщикаПолучателя(Плательщик, СчетПлательщика, 
						Получатель, СчетПолучателя, ПеречислениеВБюджет, Период);
    
    ИначеЕсли бит_ОбщегоНазначения.ЭтоСемействоERP() Тогда	
		
		// нет аналогов, вызов только в бит_Казначейство 
		
	КонецЕсли;
 	
	Возврат Реквизиты;
	
КонецФункции // СформироватьАвтоЗначенияРеквизитовПлательщикаПолучателя()

#КонецОбласти

#Область ИнтерфейсыКМетодамТиповыхКонфигураций

// Функция формирует представление суммы прописью в указанной валюте.
// 
// Возвращаемое значение:
//  Строка - сумма прописью
// 
Функция СформироватьСуммуПрописью(Сумма, Валюта) Экспорт
	
	Результат = "";
	
	Если бит_ОбщегоНазначения.ЭтоСемействоБП() Тогда		
		
		Модуль = ОбщегоНазначения.ОбщийМодуль("ОбщегоНазначенияБПВызовСервера");
		Результат = Модуль.СформироватьСуммуПрописью(Сумма, Валюта);                
		
	ИначеЕсли бит_ОбщегоНазначения.ЭтоСемействоERP() Тогда
		
		Модуль = ОбщегоНазначения.ОбщийМодуль("РаботаСКурсамиВалют");
		Результат = Модуль.СформироватьСуммуПрописью(Сумма, Валюта);                
		
	КонецЕсли; 
	
	Возврат Результат;
	
КонецФункции
   
#КонецОбласти

#КонецОбласти
