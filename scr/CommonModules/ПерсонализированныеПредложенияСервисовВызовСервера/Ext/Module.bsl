﻿Функция ПредодобренныйКредитВСбербанкеПолучитьСписокОрганизаций() Экспорт
	
	МассивИНН = ПерсонализированныеПредложенияСервисов.ПредодобренныйКредитВСбербанкеПолучитьПредодобренныеИНН();
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("МассивИНН", МассивИНН);
	Запрос.Текст =
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	Организации.Наименование КАК Наименование,
	|	Организации.ИНН КАК ИНН
	|ИЗ
	|	Справочник.Организации КАК Организации
	|ГДЕ
	|	Организации.ИНН В(&МассивИНН)
	|
	|УПОРЯДОЧИТЬ ПО
	|	Наименование";
	Выборка = Запрос.Выполнить().Выбрать();
	
	Результат = Новый СписокЗначений;
	
	Пока Выборка.Следующий() Цикл
		Результат.Добавить(Выборка.ИНН, Выборка.Наименование);
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции

Функция ПредодобренныйКредитВСбербанкеГиперссылкаПоИНН(ИНН, ИмяБаннера) Экспорт
	
	Возврат ПерсонализированныеПредложенияСервисов.ПредодобренныйКредитВСбербанкеИмяСервера()
		+ "/api/advertisement/banner?inn=" + КодироватьСтроку(ИНН, СпособКодированияСтроки.КодировкаURL)
		+ "&bannerNick=" + КодироватьСтроку(ИмяБаннера, СпособКодированияСтроки.КодировкаURL)
		+ "&programName=" + КодироватьСтроку(Метаданные.Имя, СпособКодированияСтроки.КодировкаURL)
		+ "&programVersion=" + КодироватьСтроку(бит_ОбщегоНазначения.МетаданныеВерсия(), СпособКодированияСтроки.КодировкаURL);
	
КонецФункции
