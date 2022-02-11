﻿
Процедура ЗаполнитьПараметрыФормированияТекстаЗапросаВложенныхШтрихкодов(Параметры, ДокументСсылка) Экспорт
	
	Если ТипЗнч(ДокументСсылка) = Тип("ДокументСсылка.РозничнаяПродажа") Тогда
		
		Организация = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ДокументСсылка, "Организация");
		
		Параметры.ИмяПоляАлкогольнаяПродукция = "АлкогольнаяПродукция";
		Параметры.ИмяТабЧастиАкцизныхМарок    = "Товары";
		Параметры.ОрганизацияЕГАИС            = ИнтеграцияЕГАИСБП.ОрганизацияЕГАИС(Организация);
		
	КонецЕсли;
	
КонецПроцедуры
