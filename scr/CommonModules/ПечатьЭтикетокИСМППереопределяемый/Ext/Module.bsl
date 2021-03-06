#Область ПрограммныйИнтерфейс

// Подготавливает структуру дополнительных параметров для печати этикеток.
// 
// Параметры:
// 	СтруктураНастроек - Структура - дополнительные параметры.
//
Процедура СтруктураНастроекЭтикеткаИСМП(СтруктураНастроекИтог) Экспорт
	
	Возврат;
	
КонецПроцедуры

// В данной процедуре определяется метод печати этикеток ИС МП
// 
// Параметры:
// 	ТаблицаДляПечати - Массив - Массив строк таблицы (см. РегистрыСведений.ПулКодовМаркировкиСУЗ.НоваяТаблицаДанныхДляПечатиЭтикеток)
// 	ТабличныйДокумент - ТабличныйДокумент - результат печати
// 	СтруктураНастроек - Структура - Дополнительне параметры для печати
// 	СтандартнаяОбработка - Булево - Признак использования бублиотечной печати
Процедура ПечатьЭтикетокИСМП(ТаблицаДляПечати, ТабличныйДокумент, СтруктураНастроек, СтандартнаяОбработка) Экспорт
	ИнтеграцияИСМПБП.ПечатьЭтикетокИСМП(ТаблицаДляПечати, ТабличныйДокумент, СтруктураНастроек, СтандартнаяОбработка);
КонецПроцедуры

#КонецОбласти
