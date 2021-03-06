
Процедура ПечатьРегламентированногоОтчета(Ссылка, ИмяМакетаДляПечати, СтандартнаяОбработка) Экспорт
	
	Если ТипЗнч(Ссылка) = Тип("ДокументСсылка.УведомлениеОКонтролируемыхСделках") Тогда
		
		СтандартнаяОбработка = Ложь;
		Если Не ЗначениеЗаполнено(Ссылка) Тогда 
			Возврат;
		КонецЕсли;
		
		ПараметрыПечати = Новый Структура("Уведомление", Ссылка);
		ОткрытьФорму("Документ.УведомлениеОКонтролируемыхСделках.Форма.ФормаПечатиУведомления", ПараметрыПечати);
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ВыгрузкаРегламентированногоОтчета(Ссылка) Экспорт
	
	Если ТипЗнч(Ссылка) = Тип("ДокументСсылка.УведомлениеОКонтролируемыхСделках") Тогда
		
		ПараметрыФормы = Новый Структура("Уведомление", Ссылка);
		ОткрытьФорму("Обработка.ПомощникПодготовкиУведомленияОКонтролируемыхСделках.Форма.Форма", ПараметрыФормы);
		
	КонецЕсли;
	
КонецПроцедуры

Процедура СозданиеРегламентированногоОтчета(Организация, Тип, СтандартнаяОбработка) Экспорт
	
	Если Тип = Тип("ДокументСсылка.УведомлениеОКонтролируемыхСделках") Тогда
		
		ПараметрыФормы = Новый Структура("Организация", Организация);
		ОткрытьФорму("Обработка.ПомощникПодготовкиУведомленияОКонтролируемыхСделках.Форма.Форма", ПараметрыФормы);
		
	КонецЕсли;
	
КонецПроцедуры

Процедура НалоговыеОрганыГруппОбособленныхПодразделений(Форма, Команда) Экспорт
	
	ОткрытьФорму("РегистрСведений.НастройкиУчетаНалогаНаПрибыльГруппОбособленныхПодразделений.Форма.ИФНСОтветственныхПодразделений",
		Новый Структура("Организация", Форма.ГоловнаяОрганизация),
		,
		Форма.ГоловнаяОрганизация);
	
КонецПроцедуры
