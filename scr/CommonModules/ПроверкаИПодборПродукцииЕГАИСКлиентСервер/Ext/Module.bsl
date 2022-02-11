﻿	
#Область СлужебныйПрограммныйИнтерфейс

#Область ПересчетИтогов

// Пересчитывает итоги по проверке содержимого для всех упаковок дерева. 
// 
// Параметры:
// 	ДеревоМаркированнойПродукции - ДанныеФормыДерево - дерево формы, с данными проверяемой маркируемой продукции.
//
Процедура ПересчитатьИтогиПоПроверкеСодержимогоУпаковок(ДеревоМаркированнойПродукции) Экспорт
	
	ПроверкаИПодборПродукцииИСКлиентСервер.ПересчитатьИтогиПоПроверкеСодержимогоУпаковок(
		ДеревоМаркированнойПродукции, ПроверкаИПодборПродукцииЕГАИСКлиентСервер);
	
КонецПроцедуры

// Пересчитывает итоги по проверке содержимого упаковки для всех родительских строк
// переданной строки дерева маркируемой продукции.
// 
// Параметры:
// 	СтрокаДерева - ДанныеФормыЭлементДерева - строка дерева, содержащая данные упаковки.
//
Процедура ПересчитатьИтогиПоПроверкеСодержимогоУпаковкиПриИзмененииСтроки(СтрокаДерева) Экспорт
	
	ПроверкаИПодборПродукцииИСКлиентСервер.ПересчитатьИтогиПоПроверкеСодержимогоУпаковкиПриИзмененииСтроки(
		СтрокаДерева, ПроверкаИПодборПродукцииЕГАИСКлиентСервер);
	
КонецПроцедуры

// Пересчитывает итоги по проверке содержимого упаковки для строки дерева маркируемой продукции. 
// 
// Параметры:
// 	СтрокаДерева             - ДанныеФормыЭлементДерева - строка дерева, содержащая данные упаковки.
// 	ПересчитыватьПодчиненные - Булево - признак необходимости пересчета подчиненных упаковок.
//
Процедура ПересчитатьИтогиПоПроверкеСодержимогоУпаковки(СтрокаДерева, ПересчитыватьПодчиненные) Экспорт
	
	ПодчиненныеСтроки = СтрокаДерева.ПолучитьЭлементы();
	СтрокаДерева.КоличествоПодчиненныхУпаковок      = 0;
	СтрокаДерева.КоличествоПодчиненныхБутылок       = 0;
	СтрокаДерева.КоличествоПодчиненныхВсего         = 0;
	
	СтрокаДерева.КоличествоПодчиненныхВНаличии      = 0;
	СтрокаДерева.КоличествоПодчиненныхОтсутствует   = 0;
	СтрокаДерева.КоличествоПодчиненныхОтложено      = 0;
	СтрокаДерева.КоличествоПодчиненныхНеЧислилось   = 0;
	СтрокаДерева.КоличествоПодчиненныхНеПроверялось = 0;
	
	
	Для Каждого ПодчиненнаяСтрока Из ПодчиненныеСтроки Цикл
		
		Если ПодчиненнаяСтрока.СтатусПроверки = ПредопределенноеЗначение("Перечисление.СтатусыПроверкиНаличияПродукцииИС.ВНаличии") Тогда
			
			СтрокаДерева.КоличествоПодчиненныхВНаличии = СтрокаДерева.КоличествоПодчиненныхВНаличии + 1;
			
		ИначеЕсли ПодчиненнаяСтрока.СтатусПроверки = ПредопределенноеЗначение("Перечисление.СтатусыПроверкиНаличияПродукцииИС.Отсутствует") Тогда
			
			СтрокаДерева.КоличествоПодчиненныхОтсутствует = СтрокаДерева.КоличествоПодчиненныхОтсутствует + 1;
			
		ИначеЕсли ПодчиненнаяСтрока.СтатусПроверки = ПредопределенноеЗначение("Перечисление.СтатусыПроверкиНаличияПродукцииИС.Отложена") Тогда
			
			СтрокаДерева.КоличествоПодчиненныхОтложено = СтрокаДерева.КоличествоПодчиненныхОтложено + 1;
			
		ИначеЕсли ПодчиненнаяСтрока.СтатусПроверки = ПредопределенноеЗначение("Перечисление.СтатусыПроверкиНаличияПродукцииИС.НеПроверялась") Тогда
			
			СтрокаДерева.КоличествоПодчиненныхНеПроверялось = СтрокаДерева.КоличествоПодчиненныхНеПроверялось + 1;
			
		ИначеЕсли ПодчиненнаяСтрока.СтатусПроверки = ПредопределенноеЗначение("Перечисление.СтатусыПроверкиНаличияПродукцииИС.НеЧислилась") Тогда
			
			СтрокаДерева.КоличествоПодчиненныхНеЧислилось = СтрокаДерева.КоличествоПодчиненныхНеЧислилось + 1;
			
		КонецЕсли;
		
		Если ПересчитыватьПодчиненные Тогда
		
			ПересчитатьИтогиПоПроверкеСодержимогоУпаковки(ПодчиненнаяСтрока, Истина);
		
		КонецЕсли;
		
		Если ПодчиненнаяСтрока.ТипУпаковки = ПредопределенноеЗначение("Перечисление.ТипыУпаковок.МаркированныйТовар") Тогда
			
			СтрокаДерева.КоличествоПодчиненныхБутылок  = СтрокаДерева.КоличествоПодчиненныхБутылок + 1;
			
		Иначе
			
			СтрокаДерева.КоличествоПодчиненныхУпаковок = СтрокаДерева.КоличествоПодчиненныхУпаковок + 1;
			
		КонецЕсли;
		
		СтрокаДерева.КоличествоПодчиненныхБутылок       = СтрокаДерева.КоличествоПодчиненныхБутылок       + ПодчиненнаяСтрока.КоличествоПодчиненныхБутылок ;
		СтрокаДерева.КоличествоПодчиненныхУпаковок      = СтрокаДерева.КоличествоПодчиненныхУпаковок      + ПодчиненнаяСтрока.КоличествоПодчиненныхУпаковок;
		
		СтрокаДерева.КоличествоПодчиненныхВНаличии      = СтрокаДерева.КоличествоПодчиненныхВНаличии      + ПодчиненнаяСтрока.КоличествоПодчиненныхВНаличии;
		СтрокаДерева.КоличествоПодчиненныхОтсутствует   = СтрокаДерева.КоличествоПодчиненныхОтсутствует   + ПодчиненнаяСтрока.КоличествоПодчиненныхОтсутствует;
		СтрокаДерева.КоличествоПодчиненныхОтложено      = СтрокаДерева.КоличествоПодчиненныхОтложено      + ПодчиненнаяСтрока.КоличествоПодчиненныхОтложено;
		СтрокаДерева.КоличествоПодчиненныхНеЧислилось   = СтрокаДерева.КоличествоПодчиненныхНеЧислилось   + ПодчиненнаяСтрока.КоличествоПодчиненныхНеЧислилось;
		СтрокаДерева.КоличествоПодчиненныхНеПроверялось = СтрокаДерева.КоличествоПодчиненныхНеПроверялось + ПодчиненнаяСтрока.КоличествоПодчиненныхНеПроверялось;
		
	КонецЦикла;
	
	СтрокаДерева.КоличествоПодчиненныхВсего = СтрокаДерева.КоличествоПодчиненныхУпаковок + СтрокаДерева.КоличествоПодчиненныхБутылок;

	
	СтрокаДерева.ВсяУпаковкаПроверена = Не СтрокаДерева.НеСодержитсяВДанныхДокумента
	                                    И (СтрокаДерева.КоличествоПодчиненныхУпаковок + СтрокаДерева.КоличествоПодчиненныхБутылок = СтрокаДерева.КоличествоПодчиненныхВНаличии)
	                                    И СтрокаДерева.ТипУпаковки <> ПредопределенноеЗначение("Перечисление.ТипыУпаковок.МаркированныйТовар")
	                                    И СтрокаДерева.ТипУпаковки <> ПредопределенноеЗначение("Перечисление.ПрочиеЗоныПересчетаАлкогольнойПродукции.БутылкиБезКоробки");
	
	СформироватьПредставлениеПроверкиПодчиненных(СтрокаДерева);
	СформироватьПредставлениеСодержимогоУпаковки(СтрокаДерева);
	УстановитьИндексКартинкиТипаУпаковки(СтрокаДерева);
	УстановитьИндексКартинкиСтатусаПроверки(СтрокаДерева);
	
КонецПроцедуры

// Определяет типы всех упаковок в дереве маркируемой продукции
// 
// Параметры:
// 	Форма - ФормаКлиентскогоПриложения - форма проверки и подбора с данными проверяемой маркируемой продукции.
//
Процедура ОпределитьТипыВсехУпаковок(Форма) Экспорт
	
	Для Каждого СтрокаДерева Из Форма.ДеревоМаркированнойПродукции.ПолучитьЭлементы() Цикл
		
		Если ИнтеграцияИСКлиентСервер.ЭтоУпаковка(СтрокаДерева.ТипУпаковки) Тогда
			
			ОпределитьТипУпаковки(Форма, СтрокаДерева, Истина);
			
		КонецЕсли;
		
	КонецЦикла
	
КонецПроцедуры

#КонецОбласти

#Область ПредставлениеПолейДереваМаркированнойПродукции

Процедура УстановитьИндексКартинкиТипаУпаковки(ТекущаяСтрока) Экспорт

	Если ИнтеграцияИСКлиентСервер.ЭтоУпаковка(ТекущаяСтрока.ТипУпаковки) Тогда
		
		ИдетПроверкаДаннойУпаковки = Ложь;
		
		Если НЕ ТекущаяСтрока.Свойство("ИдетПроверкаДаннойУпаковки", ИдетПроверкаДаннойУпаковки) Тогда
			ТекущаяСтрока.ИндексКартинкиШтрихкод = 0;
		ИначеЕсли ИдетПроверкаДаннойУпаковки Тогда
			ТекущаяСтрока.ИндексКартинкиШтрихкод = 3;
		Иначе
			ТекущаяСтрока.ИндексКартинкиШтрихкод = 0;
		КонецЕсли;
		
	ИначеЕсли ТекущаяСтрока.ТипУпаковки = ПредопределенноеЗначение("Перечисление.ТипыУпаковок.МаркированныйТовар") Тогда
		
		ТекущаяСтрока.ИндексКартинкиШтрихкод = 1;
		
	ИначеЕсли ТекущаяСтрока.ТипУпаковки = ПредопределенноеЗначение("Перечисление.ПрочиеЗоныПересчетаАлкогольнойПродукции.БутылкиБезКоробки") Тогда
		
		ТекущаяСтрока.ИндексКартинкиШтрихкод = 2;
		
	КонецЕсли;

КонецПроцедуры

Процедура УстановитьИндексКартинкиСостояниеПодбораАкцизныхМарок(ТекущаяСтрока) Экспорт
	
	Если НЕ ТекущаяСтрока.Маркируемая Тогда
		
		ТекущаяСтрока.ИндексАкцизнойМарки = 0;
		
	ИначеЕсли ТекущаяСтрока.КоличествоРаспределено >= ТекущаяСтрока.Количество Тогда
		
		ТекущаяСтрока.ИндексАкцизнойМарки = 1;
		
	Иначе
		
		ТекущаяСтрока.ИндексАкцизнойМарки = 2;
		
	КонецЕсли;
	
КонецПроцедуры

Процедура УстановитьИндексКартинкиСтатусаПроверки(ТекущаяСтрока) Экспорт
	
	Если ТекущаяСтрока.ТипУпаковки = ПредопределенноеЗначение("Перечисление.ПрочиеЗоныПересчетаАлкогольнойПродукции.БутылкиБезКоробки") Тогда
		
		ТекущаяСтрока.ИндексКартинкиСтатусПроверки = 5;
		
	Иначе
		
		ПроверкаИПодборПродукцииИСКлиентСервер.УстановитьИндексКартинкиСтатусаПроверки(ТекущаяСтрока,
			ПроверкаИПодборПродукцииЕГАИСКлиентСервер);
		
	КонецЕсли;
		
КонецПроцедуры

Процедура СформироватьПредставлениеДляСтрокиДереваМаркированнойПродукции(ТекущаяСтрока) Экспорт

	Если ТекущаяСтрока.ТипУпаковки = ПредопределенноеЗначение("Перечисление.ПрочиеЗоныПересчетаАлкогольнойПродукции.БутылкиБезКоробки") Тогда
		
		ТекущаяСтрока.Представление = НСтр("ru = 'Бутылки без упаковки'");
		
	Иначе
		
		ПроверкаИПодборПродукцииИСКлиентСервер.СформироватьПредставлениеДляСтрокиДереваМаркированнойПродукции(ТекущаяСтрока,
			ПроверкаИПодборПродукцииЕГАИСКлиентСервер);
		
	КонецЕсли;
	
КонецПроцедуры

Процедура СформироватьПредставлениеСодержимогоУпаковки(ТекущаяСтрока) Экспорт
	
	Если ТекущаяСтрока.ТипУпаковки = ПредопределенноеЗначение("Перечисление.ТипыУпаковок.МаркированныйТовар") Тогда
		
		ТекущаяСтрока.ПредставлениеСодержимоеУпаковки = ТекущаяСтрока.АлкогольнаяПродукция;
		
	ИначеЕсли ТекущаяСтрока.КоличествоПодчиненныхБутылок = 0
		И ТекущаяСтрока.КоличествоПодчиненныхУпаковок = 0 Тогда
		
		ТекущаяСтрока.ПредставлениеСодержимоеУпаковки = НСтр("ru = '<пустая упаковка>'");
		
		Если ТекущаяСтрока.ТипУпаковки = ПредопределенноеЗначение("Перечисление.ПрочиеЗоныПересчетаАлкогольнойПродукции.БутылкиБезКоробки") Тогда
			
			ТекущаяСтрока.ПредставлениеСодержимоеУпаковки = НСтр("ru = '<нет>'");
			
		КонецЕсли;
		
	ИначеЕсли ТекущаяСтрока.КоличествоПодчиненныхБутылок = 0 Тогда
		
		ТекущаяСтрока.ПредставлениеСодержимоеУпаковки = СтрШаблон(НСтр("ru = 'упаковок - %1'"), ТекущаяСтрока.КоличествоПодчиненныхУпаковок);
		
	ИначеЕсли ТекущаяСтрока.КоличествоПодчиненныхУпаковок = 0 Тогда
		
		ТекущаяСтрока.ПредставлениеСодержимоеУпаковки = СтрШаблон(НСтр("ru = 'бутылок -  %1'"), ТекущаяСтрока.КоличествоПодчиненныхБутылок);
		
	Иначе
		
		ТекущаяСтрока.ПредставлениеСодержимоеУпаковки = СтрШаблон(
			НСтр("ru = 'упаковок - %1, бутылок - %2'"),
			ТекущаяСтрока.КоличествоПодчиненныхУпаковок,
			ТекущаяСтрока.КоличествоПодчиненныхБутылок);
		
	КонецЕсли;
	
	Если ТекущаяСтрока.ТребуетсяПеремаркировка Тогда
		
		ТекущаяСтрока.ПредставлениеСодержимоеУпаковки = СтрШаблон(
			НСтр("ru = '(требуется перемаркировка) %1'"),
			ТекущаяСтрока.ПредставлениеСодержимоеУпаковки);
		
	КонецЕсли;
	
КонецПроцедуры

Процедура СформироватьПредставлениеПроверкиПодчиненных(ТекущаяСтрока) Экспорт
	
	ВсегоПодчиненных = ТекущаяСтрока.КоличествоПодчиненныхБутылок + ТекущаяСтрока.КоличествоПодчиненныхУпаковок;
	
	Если ТекущаяСтрока.ТипУпаковки = ПредопределенноеЗначение("Перечисление.ТипыУпаковок.МаркированныйТовар") Тогда
		
		ТекущаяСтрока.ПредставлениеПроверкиПодчиненных = НСтр("ru = '<не является упаковкой>'");
		
	ИначеЕсли ТекущаяСтрока.ТипУпаковки = ПредопределенноеЗначение("Перечисление.ПрочиеЗоныПересчетаАлкогольнойПродукции.БутылкиБезКоробки")
		Или ТекущаяСтрока.НеСодержитсяВДанныхДокумента Тогда
		
		ТекущаяСтрока.ПредставлениеПроверкиПодчиненных =  НСтр("ru = '<не применимо>'");
	
	ИначеЕсли ВсегоПодчиненных = 0 Тогда
		
		ТекущаяСтрока.ПредставлениеПроверкиПодчиненных =  НСтр("ru = '<пустая упаковка>'");
		
	ИначеЕсли ТекущаяСтрока.КоличествоПодчиненныхОтсутствует = 0
		И ТекущаяСтрока.КоличествоПодчиненныхОтложено = 0 
		И ТекущаяСтрока.КоличествоПодчиненныхНеЧислилось = 0 Тогда
		
		ТекущаяСтрока.ПредставлениеПроверкиПодчиненных =  СтрШаблон(НСтр("ru = 'Проверено %1 из %2'"),
		                                                 ТекущаяСтрока.КоличествоПодчиненныхВНаличии,
		                                                 ВсегоПодчиненных);
		
	ИначеЕсли ТекущаяСтрока.КоличествоПодчиненныхОтложено = 0
		      И ТекущаяСтрока.КоличествоПодчиненныхНеЧислилось = 0 Тогда 
		
		КоличествоПроверено = ТекущаяСтрока.КоличествоПодчиненныхВНаличии + ТекущаяСтрока.КоличествоПодчиненныхОтсутствует;
		
		ТекущаяСтрока.ПредставлениеПроверкиПодчиненных =  СтрШаблон(НСтр("ru = 'Проверено %1 из %2, отсутствует - %3'"),
		                                                 КоличествоПроверено,
		                                                 ВсегоПодчиненных,
		                                                 ТекущаяСтрока.КоличествоПодчиненныхОтсутствует);
		
	ИначеЕсли ТекущаяСтрока.КоличествоПодчиненныхОтсутствует = 0
		      И ТекущаяСтрока.КоличествоПодчиненныхНеЧислилось = 0 Тогда  
		
		КоличествоПроверено = ТекущаяСтрока.КоличествоПодчиненныхВНаличии + ТекущаяСтрока.КоличествоПодчиненныхОтложено;
		
		ТекущаяСтрока.ПредставлениеПроверкиПодчиненных =  СтрШаблон(НСтр("ru = 'Проверено %1 из %2, отложено - %3'"),
		                                                 КоличествоПроверено,
		                                                 ВсегоПодчиненных,
		                                                 ТекущаяСтрока.КоличествоПодчиненныхОтложено);
		 
	ИначеЕсли ТекущаяСтрока.КоличествоПодчиненныхОтложено = 0
		      И ТекущаяСтрока.КоличествоПодчиненныхОтсутствует = 0 Тогда
		
		КоличествоПроверено = ТекущаяСтрока.КоличествоПодчиненныхВНаличии + ТекущаяСтрока.КоличествоПодчиненныхНеЧислилось;
		
		ТекущаяСтрока.ПредставлениеПроверкиПодчиненных =  СтрШаблон(НСтр("ru = 'Проверено %1 из %2, не числилось - %3'"),
		                                                 КоличествоПроверено,
		                                                 ВсегоПодчиненных,
		                                                 ТекущаяСтрока.КоличествоПодчиненныхНеЧислилось);
		
	ИначеЕсли ТекущаяСтрока.КоличествоПодчиненныхОтложено = 0 Тогда 
		
		КоличествоПроверено = ТекущаяСтрока.КоличествоПодчиненныхВНаличии + ТекущаяСтрока.КоличествоПодчиненныхОтсутствует 
		                    + ТекущаяСтрока.КоличествоПодчиненныхНеЧислилось;
		
		ТекущаяСтрока.ПредставлениеПроверкиПодчиненных =  СтрШаблон(НСтр("ru = 'Проверено %1 из %2, отсутствует - %3, не числилось - %4'"),
		                                                 КоличествоПроверено,
		                                                 ВсегоПодчиненных,
		                                                 ТекущаяСтрока.КоличествоПодчиненныхОтсутствует,
		                                                 ТекущаяСтрока.КоличествоПодчиненныхНеЧислилось);
		
	ИначеЕсли ТекущаяСтрока.КоличествоПодчиненныхОтсутствует = 0 Тогда 
		
		КоличествоПроверено = ТекущаяСтрока.КоличествоПодчиненныхВНаличии + ТекущаяСтрока.КоличествоПодчиненныхОтложено 
		                    + ТекущаяСтрока.КоличествоПодчиненныхНеЧислилось;
		
		ТекущаяСтрока.ПредставлениеПроверкиПодчиненных =  СтрШаблон(НСтр("ru = 'Проверено %1 из %2, отложено - %3, не числилось - %4'"),
		                                                 КоличествоПроверено,
		                                                 ВсегоПодчиненных,
		                                                 ТекущаяСтрока.КоличествоПодчиненныхОтложено,
		                                                 ТекущаяСтрока.КоличествоПодчиненныхНеЧислилось);
		
	ИначеЕсли ТекущаяСтрока.КоличествоПодчиненныхНеЧислилось = 0 Тогда 
		
		КоличествоПроверено = ТекущаяСтрока.КоличествоПодчиненныхВНаличии + ТекущаяСтрока.КоличествоПодчиненныхОтложено 
		                    + ТекущаяСтрока.КоличествоПодчиненныхОтсутствует;
		
		ТекущаяСтрока.ПредставлениеПроверкиПодчиненных =  СтрШаблон(НСтр("ru = 'Проверено %1 из %2, отложено - %3, отсутствует - %4'"),
		                                                 КоличествоПроверено,
		                                                 ВсегоПодчиненных,
		                                                 ТекущаяСтрока.КоличествоПодчиненныхОтложено,
		                                                 ТекущаяСтрока.КоличествоПодчиненныхОтсутствует);
		
	Иначе
		
		КоличествоПроверено = ТекущаяСтрока.КоличествоПодчиненныхВНаличии + ТекущаяСтрока.КоличествоПодчиненныхОтложено 
		                    + ТекущаяСтрока.КоличествоПодчиненныхНеЧислилось + ТекущаяСтрока.КоличествоПодчиненныхОтсутствует;
		
		ТекущаяСтрока.ПредставлениеПроверкиПодчиненных =  СтрШаблон(НСтр("ru = 'Проверено %1 из %2, отсутствует - %3, отложено - %4, не числилось - %5'"),
		                                                 КоличествоПроверено,
		                                                 ВсегоПодчиненных,
		                                                 ТекущаяСтрока.КоличествоПодчиненныхОтсутствует,
		                                                 ТекущаяСтрока.КоличествоПодчиненныхОтложено,
		                                                 ТекущаяСтрока.КоличествоПодчиненныхНеЧислилось);
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбновитьВыводимоеПредставлениеПроверкиСодержимого(Форма, ТекущаяСтрока) Экспорт
	
	ПроверкаИПодборПродукцииИСКлиентСервер.ОбновитьВыводимоеПредставлениеПроверкиСодержимого(Форма,
		ТекущаяСтрока, ПроверкаИПодборПродукцииЕГАИСКлиентСервер);
	
КонецПроцедуры

#КонецОбласти

#Область ОпределениеТипаУпаковки

Процедура ОпределитьТипУпаковкиПриИзмененииСтроки(Форма, ИдентификаторИзмененнойСтроки) Экспорт

	ИзмененнаяСтрока = Форма.ДеревоМаркированнойПродукции.НайтиПоИдентификатору(ИдентификаторИзмененнойСтроки);
	
	Если ИзмененнаяСтрока = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если ИнтеграцияИСКлиентСервер.ЭтоУпаковка(ИзмененнаяСтрока.ТипУпаковки) Тогда
		
		ОпределитьТипУпаковки(Форма, ИзмененнаяСтрока, Ложь);
		
	КонецЕсли;
	
	РодительИзмененнойСтроки = ИзмененнаяСтрока.ПолучитьРодителя();
	
	Пока РодительИзмененнойСтроки <> Неопределено 
		И ИнтеграцияИСКлиентСервер.ЭтоУпаковка(РодительИзмененнойСтроки.ТипУпаковки) Цикл
		
		ОпределитьТипУпаковки(Форма, РодительИзмененнойСтроки, Ложь);
		РодительИзмененнойСтроки = РодительИзмененнойСтроки.ПолучитьРодителя();
		
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#Область Перемаркировка

// Формирует и отображает на форме информационную надпись о необходимости перемаркировки.
// 
// Параметры:
// 	Форма - ФормаКлиентскогоПриложения - форма проверки и подбора, для которой формируется надпись.
//
Процедура ОтобразитьИнформациюОНеобходимостиПеремаркировки(Форма) Экспорт
	
	ПроверкаИПодборПродукцииИСКлиентСервер.ОтобразитьИнформациюОНеобходимостиПеремаркировки(
		Форма, ПроверкаИПодборПродукцииЕГАИСКлиентСервер);
	
КонецПроцедуры

Процедура ПроверитьНеобходимостьПеремаркировки(Форма, ТаблицаПеремаркировки, ЭтоВыборочнаяПроверка) Экспорт
	
	ПроверкаИПодборПродукцииИСКлиентСервер.ПроверитьНеобходимостьПеремаркировки(
		Форма, ТаблицаПеремаркировки, ЭтоВыборочнаяПроверка, ПроверкаИПодборПродукцииЕГАИСКлиентСервер);
	
КонецПроцедуры

Процедура УстановитьОтборТребуетсяПеремаркировкаВСтрокеДерева(СтрокаДерева, СоответствуетОтбору) Экспорт
	
	ПроверкаИПодборПродукцииИСКлиентСервер.УстановитьОтборТребуетсяПеремаркировкаВСтрокеДерева(
		СтрокаДерева, СоответствуетОтбору, ПроверкаИПодборПродукцииЕГАИСКлиентСервер);
	
КонецПроцедуры

Функция ЗаголовокТребуетсяПеремаркировка(Форма) Экспорт
	
	ТекстТребуется = СтрШаблон(НСтр("ru = 'Требуется перемаркировка упаковок - %1.'"), Форма.КоличествоУпаковокКоторыеНеобходимоПеремаркировать);
	СтрокаТребуется = Новый ФорматированнаяСтрока(ТекстТребуется,, Форма.ЦветТекстаТребуетВнимания);
	
	Если Форма.УстановленОтборТребуетсяПеремаркировать Тогда
		ТекстОтбор = НСтр("ru = '(снять отбор)'");
	Иначе
		ТекстОтбор = НСтр("ru = '(отобрать)'");
	КонецЕсли;
	
	СтрокаОтбор = Новый ФорматированнаяСтрока(ТекстОтбор,, Форма.ЦветГиперссылки,, "ИзменитьОтборТребуетсяПеремаркировка");
	
	Возврат Новый ФорматированнаяСтрока(СтрокаТребуется, " ", СтрокаОтбор);
	
КонецФункции

#КонецОбласти

Процедура ЗаполнитьСтрокуБутылкиБезКоробки(ТекущаяСтрока) Экспорт
	
	ТекущаяСтрока.ТипУпаковки            = ПредопределенноеЗначение("Перечисление.ПрочиеЗоныПересчетаАлкогольнойПродукции.БутылкиБезКоробки");
	ТекущаяСтрока.Представление          = НСтр("ru = 'Бутылки без упаковки'");
	
	УстановитьИндексКартинкиТипаУпаковки(ТекущаяСтрока);
	
КонецПроцедуры

Процедура УстановитьДоступностьУпаковкиДляПроверки(ТекущаяСтрока, ДоступныеДляПроверкиУпаковки) Экспорт
	
	ПроверкаИПодборПродукцииИСКлиентСервер.УстановитьДоступностьУпаковкиДляПроверки(ТекущаяСтрока,
		ДоступныеДляПроверкиУпаковки, ПроверкаИПодборПродукцииЕГАИСКлиентСервер);
	
КонецПроцедуры

Функция КолонкиТаблицыАкцизныеМаркиСтрокой() Экспорт
	
	Возврат "ИдентификаторСтроки,КодАкцизнойМарки,АкцизнаяМарка,ШтрихкодУпаковки,Справка2,Количество";
	
КонецФункции

#КонецОбласти


#Область СлужебныеПроцедурыИФункции

#Область ОпределениеТипаУпаковки

Процедура ОпределитьТипУпаковки(Форма, СтрокаДерева, ВключаяПодчиненные)
	
	АлкогольнаяПродукцияУпаковки = Новый Соответствие;
	НоменклатураУпаковки         = Новый Соответствие;
	ХарактеристикаУпаковки       = Новый Соответствие;
	СерииУпаковки                = Новый Соответствие;
	Справки2Упаковки             = Новый Соответствие;
	ДлиныМарокУпаковки           = Новый Соответствие;
	
	ВУпаковкеРазныеСерии                = Ложь;
	ВУпаковкеРазнаяНоменклатура         = Ложь;
	ВУпаковкеРазныеХарактеристики       = Ложь;
	ВУпаковкеРазнаяАлкогольнаяПродукция = Ложь;
	ВУпаковкеРазныеСправки2             = Ложь;
	ВУпаковкеРазныеДлиныМарок           = Ложь;
	
	ВсеСправки2Указаны           = Истина;
	
	Для Каждого ПодчиненнаяСтрока Из СтрокаДерева.ПолучитьЭлементы() Цикл
		
		Если ИнтеграцияИСКлиентСервер.ЭтоУпаковка(ПодчиненнаяСтрока.ТипУпаковки) Тогда
			
			Если ВключаяПодчиненные Тогда
				
				ОпределитьТипУпаковки(Форма, ПодчиненнаяСтрока, ВключаяПодчиненные);
				
			КонецЕсли;
			
			Если Не ПодчиненнаяСтрока.ВсеСправки2Указаны Тогда
				ВсеСправки2Указаны = Ложь;
			КонецЕсли;
			
		Иначе
			
			Если Не ЗначениеЗаполнено(ПодчиненнаяСтрока.Справка2) Тогда
				
				ВсеСправки2Указаны = Ложь;
				ПодчиненнаяСтрока.ВсеСправки2Указаны = Ложь;
				
			Иначе
				
				ПодчиненнаяСтрока.ВсеСправки2Указаны = Истина;
				
			КонецЕсли;
			
		КонецЕсли;
		
		Если Не Форма.РежимПодбораСуществующихУпаковок
			И СтрокаДерева.ТипУпаковки = ПредопределенноеЗначение("Перечисление.ТипыУпаковок.МаркированныйТовар")
			И Не ЗначениеЗаполнено(СтрокаДерева.Номенклатура) Тогда
			
			ПараметрыПоиска = Новый Структура;
			ПараметрыПоиска.Вставить("Справка2", СтрокаДерева.Справка2);
			
			НайденныеСтроки = Форма.Справки2СопоставленнаяНоменклатура.НайтиСтроки(ПараметрыПоиска);
			
			Если НайденныеСтроки.Количество() > 0 Тогда
				
				СтрокаДерева.Номенклатура   = НайденныеСтроки.Номенклатура;
				СтрокаДерева.Характеристика = НайденныеСтроки.Характеристика;
				
			КонецЕсли;
			
		КонецЕсли;
		
		Если ПодчиненнаяСтрока.ВУпаковкеРазнаяАлкогольнаяПродукция Тогда
			ВУпаковкеРазнаяАлкогольнаяПродукция = Истина;
		КонецЕсли;
		
		Если ПодчиненнаяСтрока.ВУпаковкеРазнаяНоменклатура Тогда
			ВУпаковкеРазнаяНоменклатура = Истина;
		КонецЕсли;
		
		Если ПодчиненнаяСтрока.ВУпаковкеРазныеХарактеристики Тогда
			ВУпаковкеРазныеХарактеристики = Истина;
		КонецЕсли;
		
		Если ПодчиненнаяСтрока.ВУпаковкеРазныеСправки2 Тогда
			ВУпаковкеРазныеСправки2 = Истина;
		КонецЕсли;
		
		Если ПодчиненнаяСтрока.ВУпаковкеРазныеСерии Тогда
			ВУпаковкеРазныеСерии = Истина;
		КонецЕсли;
		
		Если ПодчиненнаяСтрока.ВУпаковкеРазныеДлиныМарок Тогда
			ВУпаковкеРазныеДлиныМарок = Истина;
		КонецЕсли;
		
		АлкогольнаяПродукцияУпаковки.Вставить(ПодчиненнаяСтрока.АлкогольнаяПродукция, Истина);
		НоменклатураУпаковки.Вставить(ПодчиненнаяСтрока.Номенклатура, Истина);
		ХарактеристикаУпаковки.Вставить(ПодчиненнаяСтрока.Характеристика, Истина);
		Справки2Упаковки.Вставить(ПодчиненнаяСтрока.Справка2, Истина);
		СерииУпаковки.Вставить(ПодчиненнаяСтрока.Серия, Истина);
		ДлиныМарокУпаковки.Вставить(ПодчиненнаяСтрока.ДлинаАкцизнойМарки, Истина);
		
	КонецЦикла;
	
	СтрокаДерева.ВсеСправки2Указаны = ВсеСправки2Указаны;
	
	ПроверкаИПодборПродукцииИСКлиентСервер.УстановитьЗначениеДляУпаковки(СтрокаДерева,
		"АлкогольнаяПродукция", "ВУпаковкеРазнаяАлкогольнаяПродукция",
		АлкогольнаяПродукцияУпаковки, ВУпаковкеРазнаяАлкогольнаяПродукция);
	
	ПроверкаИПодборПродукцииИСКлиентСервер.УстановитьЗначениеДляУпаковки(СтрокаДерева,
		"Номенклатура", "ВУпаковкеРазнаяНоменклатура",
		НоменклатураУпаковки, ВУпаковкеРазнаяНоменклатура);
	
	ПроверкаИПодборПродукцииИСКлиентСервер.УстановитьЗначениеДляУпаковки(СтрокаДерева,
		"Характеристика", "ВУпаковкеРазныеХарактеристики",
		ХарактеристикаУпаковки, ВУпаковкеРазныеХарактеристики);
	
	ПроверкаИПодборПродукцииИСКлиентСервер.УстановитьЗначениеДляУпаковки(СтрокаДерева,
		"Серия", "ВУпаковкеРазныеСерии",
		СерииУпаковки, ВУпаковкеРазныеСерии);
	
	ПроверкаИПодборПродукцииИСКлиентСервер.УстановитьЗначениеДляУпаковки(СтрокаДерева,
		"Справка2", "ВУпаковкеРазныеСправки2",
		Справки2Упаковки, ВУпаковкеРазныеСправки2);
	
	ПроверкаИПодборПродукцииИСКлиентСервер.УстановитьЗначениеДляУпаковки(СтрокаДерева,
		"ДлинаАкцизнойМарки", "ВУпаковкеРазныеДлиныМарок",
		ДлиныМарокУпаковки, ВУпаковкеРазныеДлиныМарок);
	
	Если ЗначениеЗаполнено(СтрокаДерева.Номенклатура) Тогда
		СтрокаДерева.ТипУпаковки = ПредопределенноеЗначение("Перечисление.ТипыУпаковок.МонотоварнаяУпаковка");
	Иначе
		СтрокаДерева.ТипУпаковки = ПредопределенноеЗначение("Перечисление.ТипыУпаковок.МультитоварнаяУпаковка");
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

