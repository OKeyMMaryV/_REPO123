//ОК(СофтЛаб) Вдовиченко Г.В. 20190806

#Область ПрограммныйИнтерфейс

Функция ВидЗагружаемогоДокументаЯвляетсяПоступлением(ВидЗагружаемогоДокумента) Экспорт
	
	Если ВидЗагружаемогоДокумента = ПредопределенноеЗначение("Перечисление.ок_ВидЗагружаемыхДокументовЭД.КорректировкаПоступления") Тогда	
		
		Возврат Истина;
		
	ИначеЕсли (Лев(Нрег(Строка(ВидЗагружаемогоДокумента)), 11) = "поступление") Тогда
		
		Возврат Истина;
		
	КонецЕсли;
	
	Возврат Ложь;
	
КонецФункции	

Функция ВидЗагружаемогоДокументаЯвляетсяСчетомФактурой(ВидЗагружаемогоДокумента) Экспорт
	
	Возврат ВидЗагружаемогоДокумента = ПредопределенноеЗначение("Перечисление.ок_ВидЗагружаемыхДокументовЭД.СчетФактура");

КонецФункции	

Функция ВидЗагружаемогоДокументаПоступленияПоТабличнойЧасти(ТабличнаяЧасть, ЭтоФорма = Истина) Экспорт
	
	ок_ВидЗагружаемогоДокумента = Неопределено;
	Для каждого Строка из ТабличнаяЧасть Цикл
		
		Если ЭтоФорма Тогда
			Если Не Строка.Формировать Тогда
				Продолжить;
			КонецЕсли;
		КонецЕсли;
		
		Если ок_ОбменСКонтрагентамиКлиентСервер.ВидЗагружаемогоДокументаЯвляетсяПоступлением(Строка.ВидЗагружаемогоДокумента) Тогда
			ок_ВидЗагружаемогоДокумента = Строка.ВидЗагружаемогоДокумента;
			Прервать;
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат ок_ВидЗагружаемогоДокумента;
	
КонецФункции

Функция УказанВидЗагружаемогоДокументаСчетФактураПоТабличнойЧасти(ТабличнаяЧасть, ЭтоФорма = Истина) Экспорт
	
	Для каждого Строка из ТабличнаяЧасть Цикл
		
		Если ЭтоФорма Тогда
			Если Не Строка.Формировать Тогда
				Продолжить;
			КонецЕсли;
		КонецЕсли;
		
		Если Строка.ВидЗагружаемогоДокумента = ПредопределенноеЗначение("Перечисление.ок_ВидЗагружаемыхДокументовЭД.СчетФактура") Тогда
			Возврат Истина;
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат Ложь;
	
КонецФункции

#КонецОбласти
