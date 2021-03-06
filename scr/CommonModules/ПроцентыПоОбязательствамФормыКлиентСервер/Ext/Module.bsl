// Содержимое модуля отличается в версиях ПРОФ и КОРП

#Область СлужебныйПрограммныйИнтерфейс

#Область ПоступлениеВАренду

Процедура ЗаполнитьСписокВыбораСпособОценкиАрендыБУПоступление(Форма) Экспорт
	
	Элементы = Форма.Элементы;
	Объект = Форма.Объект;
	
	Элементы.СпособОценкиАрендыБУ.СписокВыбора.Очистить();
	Элементы.СпособОценкиАрендыБУ.СписокВыбора.Добавить(
		ПредопределенноеЗначение("Перечисление.СпособыОценкиБУ.РавнаСуммеДоговора"));
	
	Если Не Форма.ПрименяетсяФСБУ25 И Не Объект.ПереходНаФСБУ25 
		Или Не Форма.ЕстьРасширенныйФункционал Тогда
		Возврат;
	КонецЕсли;
	
	Если Форма.Лизинг И Не Объект.ПереходНаФСБУ25 Тогда
		Элементы.СпособОценкиАрендыБУ.СписокВыбора.Добавить(
			ПредопределенноеЗначение("Перечисление.СпособыОценкиБУ.РавнаРасходамЛизингодателя"));
	КонецЕсли;
	
	Элементы.СпособОценкиАрендыБУ.СписокВыбора.Добавить(
		ПредопределенноеЗначение("Перечисление.СпособыОценкиБУ.РассчитываетсяПоСтавке"));
	
	Если Не Объект.ПереходНаФСБУ25 Тогда
		Элементы.СпособОценкиАрендыБУ.СписокВыбора.Добавить(
			ПредопределенноеЗначение("Перечисление.СпособыОценкиБУ.УказываетсяВручную"));
	КонецЕсли;
	
КонецПроцедуры

Процедура УстановитьСпособОценкиАрендыБУПоступление(Форма) Экспорт
	
	Элементы = Форма.Элементы;
	Объект = Форма.Объект;
	
	Если Элементы.СпособОценкиАрендыБУ.СписокВыбора.НайтиПоЗначению(Объект.СпособОценкиАрендыБУ) <> Неопределено Тогда
		// Текущее значение подходит
		Возврат;
	КонецЕсли;
	
	Если Не Форма.ЕстьРасширенныйФункционал Тогда
		СпособОценкиАрендыБУ = ПредопределенноеЗначение("Перечисление.СпособыОценкиБУ.РавнаСуммеДоговора");
	ИначеЕсли Не Форма.ПлательщикНалогаНаПрибыль Тогда
		СпособОценкиАрендыБУ = ПредопределенноеЗначение("Перечисление.СпособыОценкиБУ.РавнаСуммеДоговора");
	ИначеЕсли Объект.ПереходНаФСБУ25 Тогда
		СпособОценкиАрендыБУ = ПредопределенноеЗначение("Перечисление.СпособыОценкиБУ.РассчитываетсяПоСтавке");
	ИначеЕсли Не Форма.ПрименяетсяФСБУ25 Тогда
		СпособОценкиАрендыБУ = ПредопределенноеЗначение("Перечисление.СпособыОценкиБУ.РавнаСуммеДоговора");
	ИначеЕсли Форма.Лизинг Тогда
		СпособОценкиАрендыБУ = ПредопределенноеЗначение("Перечисление.СпособыОценкиБУ.РавнаРасходамЛизингодателя");
	Иначе
		СпособОценкиАрендыБУ = ПредопределенноеЗначение("Перечисление.СпособыОценкиБУ.РассчитываетсяПоСтавке");
	КонецЕсли;
	
	Если Элементы.СпособОценкиАрендыБУ.СписокВыбора.НайтиПоЗначению(Объект.СпособОценкиАрендыБУ) <> Неопределено Тогда
		Объект.СпособОценкиАрендыБУ = СпособОценкиАрендыБУ;
	ИначеЕсли Элементы.СпособОценкиАрендыБУ.СписокВыбора.Количество() > 0 Тогда
		Объект.СпособОценкиАрендыБУ = Элементы.СпособОценкиАрендыБУ.СписокВыбора[0].Значение;
	Иначе
		Объект.СпособОценкиАрендыБУ = ПредопределенноеЗначение("Перечисление.СпособыОценкиБУ.РавнаСуммеДоговора");
	КонецЕсли;
	
КонецПроцедуры

Процедура УправлениеФормойПоступление(Форма) Экспорт
	
	Элементы = Форма.Элементы;
	Объект   = Форма.Объект;
	
	Элементы.СпособОценкиАрендыБУ.Видимость = Форма.ПрименяетсяФСБУ25 Или Объект.ПереходНаФСБУ25;
	
	Элементы.ГруппаСтавкаДисконтирования.Видимость = ОценкаРассчитываетсяПоСтавке(Форма, "СпособОценкиАрендыБУ");
	Элементы.НадписьГрафикПлатежей.Видимость = (Форма.ПрименяетсяФСБУ25 Или Объект.ПереходНаФСБУ25)
		И Не ОценкаРавнаСуммеДоговора(Форма, "СпособОценкиАрендыБУ");
	
	Элементы.ПредметыАрендыОценкаБУ.Видимость = ОценкаУказываетсяВручную(Форма, "СпособОценкиАрендыБУ");
	Элементы.ПредметыАрендыРасходыЛизингодателя.Видимость = Элементы.ПредметыАрендыРасходыЛизингодателя.Видимость
		Или Форма.Лизинг И Не Объект.ПереходНаФСБУ25
		И ОценкаРавнаРасходамЛизингодателя(Форма, "СпособОценкиАрендыБУ");
	
КонецПроцедуры

#КонецОбласти

#Область ИзменениеУсловийАренды

Процедура ЗаполнитьСписокВыбораСпособОценкиАрендыБУИзменение(Форма) Экспорт
	
	Элементы = Форма.Элементы;
	
	Элементы.СпособОценкиАрендыБУ.СписокВыбора.Очистить();
	Элементы.СпособОценкиАрендыБУ.СписокВыбора.Добавить(
		ПредопределенноеЗначение("Перечисление.СпособыОценкиБУ.РавнаСуммеДоговора"));
	
	Если Не Форма.ПрименяетсяФСБУ25 
		Или Не Форма.ЕстьРасширенныйФункционал Тогда
		Возврат;
	КонецЕсли;
	
	Элементы.СпособОценкиАрендыБУ.СписокВыбора.Добавить(
		ПредопределенноеЗначение("Перечисление.СпособыОценкиБУ.РассчитываетсяПоСтавке"));
	Элементы.СпособОценкиАрендыБУ.СписокВыбора.Добавить(
		ПредопределенноеЗначение("Перечисление.СпособыОценкиБУ.УказываетсяВручную"));
	
КонецПроцедуры

Процедура УстановитьСпособОценкиАрендыБУИзменение(Форма) Экспорт
	
	Элементы = Форма.Элементы;
	Объект = Форма.Объект;
	
	Если Элементы.СпособОценкиАрендыБУ.СписокВыбора.НайтиПоЗначению(Объект.СпособОценкиАрендыБУ) <> Неопределено Тогда
		// Текущее значение подходит
		Возврат;
	КонецЕсли;
	
	Если Не Форма.ЕстьРасширенныйФункционал 
		Или Не Форма.ПлательщикНалогаНаПрибыль Тогда
		СпособОценкиАрендыБУ = ПредопределенноеЗначение("Перечисление.СпособыОценкиБУ.РавнаСуммеДоговора");
	Иначе
		СпособОценкиАрендыБУ = ПредопределенноеЗначение("Перечисление.СпособыОценкиБУ.РассчитываетсяПоСтавке");
	КонецЕсли;
	
	Если Элементы.СпособОценкиАрендыБУ.СписокВыбора.НайтиПоЗначению(Объект.СпособОценкиАрендыБУ) <> Неопределено Тогда
		Объект.СпособОценкиАрендыБУ = СпособОценкиАрендыБУ;
	ИначеЕсли Элементы.СпособОценкиАрендыБУ.СписокВыбора.Количество() > 0 Тогда
		Объект.СпособОценкиАрендыБУ = Элементы.СпособОценкиАрендыБУ.СписокВыбора[0].Значение;
	Иначе
		Объект.СпособОценкиАрендыБУ = ПредопределенноеЗначение("Перечисление.СпособыОценкиБУ.РавнаСуммеДоговора");
	КонецЕсли;
	
КонецПроцедуры

Процедура УправлениеФормойИзменение(Форма) Экспорт
	
	Элементы = Форма.Элементы;
	Объект   = Форма.Объект;
	
	Элементы.ГруппаОценкаАрендыБУ.Видимость = Форма.ЕстьРасширенныйФункционал;
	
	Элементы.СпособОценкиАрендыБУ.Видимость = Форма.ПрименяетсяФСБУ25;
	
	Элементы.ГруппаСтавкаДисконтирования.Видимость = ОценкаРассчитываетсяПоСтавке(Форма, "СпособОценкиАрендыБУ");
	Элементы.НадписьГрафикПлатежей.Видимость = Не ОценкаРавнаСуммеДоговора(Форма, "СпособОценкиАрендыБУ");
	Элементы.ПредметыАрендыОценкаБУ.Видимость = ОценкаУказываетсяВручную(Форма, "СпособОценкиАрендыБУ");
	
КонецПроцедуры

#КонецОбласти

Процедура СформироватьНадписьГрафикПлатежей(Форма, СпособОценки) Экспорт
	
	Объект = Форма.Объект;
	
	Если Объект.ГрафикПлатежей.Количество() = 0 Тогда
		Форма.НадписьГрафикПлатежей = НСтр("ru = '<не задан>'");
	Иначе
		СуммаПлатежей = Объект.ГрафикПлатежей.Итог("СуммаПлатежа");
		ПерваяДата = Объект.ГрафикПлатежей[0].ДатаПлатежа;
		ПоследняяДата = Объект.ГрафикПлатежей[Объект.ГрафикПлатежей.Количество() - 1].ДатаПлатежа;
		Форма.НадписьГрафикПлатежей = СтрШаблон(НСтр("ru = '%1 с %2 по %3'"),
			Формат(СуммаПлатежей, "ЧДЦ=2; ЧН="),
			Формат(ПерваяДата, "ДЛФ=D"),
			Формат(ПоследняяДата, "ДЛФ=D"));
	КонецЕсли;
	
	Форма.ГрафикПлатежейЗаполнен = ОценкаРавнаСуммеДоговора(Форма, СпособОценки)
		Или СуммаПлатежей = Форма.Всего;
	
КонецПроцедуры

Функция ОценкаРассчитываетсяПоСтавке(Форма, СпособОценки) Экспорт
	
	Результат = Форма.Объект[СпособОценки] =
		ПредопределенноеЗначение("Перечисление.СпособыОценкиБУ.РассчитываетсяПоСтавке");
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти

#Область СлужебныкПроцедурыИФункции

Функция ОценкаРавнаСуммеДоговора(Форма, СпособОценки)
	
	Результат = Форма.Объект[СпособОценки] =
		ПредопределенноеЗначение("Перечисление.СпособыОценкиБУ.РавнаСуммеДоговора");
	
	Возврат Результат;
	
КонецФункции

Функция ОценкаРавнаРасходамЛизингодателя(Форма, СпособОценки)
	
	Результат = Форма.Объект[СпособОценки] =
		ПредопределенноеЗначение("Перечисление.СпособыОценкиБУ.РавнаРасходамЛизингодателя");
	
	Возврат Результат;
	
КонецФункции

Функция ОценкаУказываетсяВручную(Форма, СпособОценки)
	
	Результат = Форма.Объект[СпособОценки] =
		ПредопределенноеЗначение("Перечисление.СпособыОценкиБУ.УказываетсяВручную")
		Или Форма.Объект[СпособОценки] = ПредопределенноеЗначение("Перечисление.СпособыОценкиБУ.ПоЦенеБезРассрочки");
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти
