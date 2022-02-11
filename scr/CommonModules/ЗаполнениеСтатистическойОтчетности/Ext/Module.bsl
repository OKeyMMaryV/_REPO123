﻿#Область СлужебныеПроцедурыИФункции
Процедура ЗаполнитьДаннымиПредидущегоПериода(Форма, МакетПереноса, ТекстОписанияПроблемы) Экспорт
	Если Не Форма.СтруктураРеквизитовФормы.РеализованоАвтозаполнениеДаннымиПредидущегоПериода Тогда 
		Возврат;
	КонецЕсли;
	
	ОбособленноеПодразделение = УниверсальныйОтчетСтатистики.ПолучитьРеквизитФормыОбособленноеПодразделение(Форма);
	ДокументыПП = ПолучитьДокументыПредидущихПериодов(Форма, МакетПереноса, ТекстОписанияПроблемы, ОбособленноеПодразделение);
	Если ДокументыПП.Количество() > 0 Тогда 
		ЗаполнитьДаннымиПредидущегоПериодаПоДокументу(Форма, МакетПереноса, ДокументыПП);
		ЗаполнитьМногострочнымиДаннымиПредидущегоПериодаПоДокументу(Форма, МакетПереноса, ДокументыПП);
		Форма.ПослеЗаполненияДаннымиОтчетов();
	КонецЕсли;
КонецПроцедуры

Процедура ЗаполнитьДаннымиПредидущегоПериодаПоДокументу(Форма, МакетПереноса, ДанныеПП)
	Макет = РегламентированнаяОтчетностьВызовСервера.ОбъектОтчета(Форма.ИмяФормы).ПолучитьМакет(МакетПереноса);
	ОбластьИнформацияОДанных = Макет.Области.Найти("ИнформацияОДанных");
	Если ОбластьИнформацияОДанных = Неопределено Тогда 
		Возврат;
	КонецЕсли;
	
	ИмяТД = "";
	Для Инд = ОбластьИнформацияОДанных.Верх По ОбластьИнформацияОДанных.Низ Цикл 
		ИдТД = Макет.Область(Инд, 1, Инд, 1).Текст;
		Если Нрег(ИдТД) = НРег("ТабличныйДокумент") Тогда 
			ИмяТД = Макет.Область(Инд, 2, Инд, 2).Текст;
		КонецЕсли;
	КонецЦикла;
	
	Если Не ЗначениеЗаполнено(ИмяТД) Тогда 
		Возврат;
	КонецЕсли;
	
	РегламентированнаяОтчетностьКлиентСервер.СобратьДанныеТекущегоТаблПоля(Форма, ИмяТД);
	ОбластьПравилаПереноса = Макет.Области.Найти(ИмяТД);
	Если ОбластьПравилаПереноса <> Неопределено Тогда 
		Для Инд = ОбластьПравилаПереноса.Верх По ОбластьПравилаПереноса.Низ Цикл 
			ИдПравило = Макет.Область(Инд, 1, Инд, 1).Текст;
			Если Не ЗначениеЗаполнено(ИдПравило) Тогда 
				Прервать;
			КонецЕсли;
			
			Данные = ДанныеПП[ИдПравило];
			Если ЗначениеЗаполнено(Данные) Тогда 
				ПолеПриемник = Макет.Область(Инд, 2, Инд, 2).Текст;
				Итер = 0;
				ПолеИсточник = "";
				Пока Истина Цикл 
					ПолеФорма = Макет.Область(Инд, 2*Итер + 3, Инд, 2*Итер + 3).Текст;
					Если Не ЗначениеЗаполнено(ПолеФорма) Тогда 
						Прервать;
					КонецЕсли;
					Если ПолеФорма = "*" Или СтрНайти(ПолеФорма, Данные.Форма) > 0 Тогда 
						ПолеИсточник = Макет.Область(Инд, 2*Итер + 4, Инд, 2*Итер + 4).Текст;
						Прервать;
					КонецЕсли;
					Итер = Итер + 1;
				КонецЦикла;
				
				Если ЗначениеЗаполнено(ПолеИсточник) Тогда 
					Форма[ИмяТД].Области[ПолеПриемник].Значение = Данные.ДанныеОтчета.ПоказателиОтчета[ИмяТД][ПолеИсточник];
				КонецЕсли;
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
КонецПроцедуры

Процедура ЗаполнитьМногострочнымиДаннымиПредидущегоПериодаПоДокументу(Форма, МакетПереноса, ДанныеПП)
	Макет = РегламентированнаяОтчетностьВызовСервера.ОбъектОтчета(Форма.ИмяФормы).ПолучитьМакет(МакетПереноса);
	ОбластьИнформацияОДанных = Макет.Области.Найти("ИнформацияОДанных");
	Если ОбластьИнформацияОДанных = Неопределено Тогда 
		Возврат;
	КонецЕсли;
	
	МногострочныеЧасти = Новый Соответствие;
	Для Инд = ОбластьИнформацияОДанных.Верх По ОбластьИнформацияОДанных.Низ Цикл 
		ИдТД = Макет.Область(Инд, 1, Инд, 1).Текст;
		Если Нрег(ИдТД) = НРег("МногострочнаяЧасть") Тогда 
			СтрЗначение = Новый Структура;
			СтрЗначение.Вставить("ГрупповыеПоля", Макет.Область(Инд, 4, Инд, 4).Текст);
			СтрЗначение.Вставить("ПоляОписания", Макет.Область(Инд, 5, Инд, 5).Текст);
			СтрЗначение.Вставить("СуммируемыеПоля", Макет.Область(Инд, 6, Инд, 6).Текст);
			СтрЗначение.Вставить("ВалидноДляФорм", Макет.Область(Инд, 3, Инд, 3).Текст);
			
			МногострочныеЧасти[Макет.Область(Инд, 2, Инд, 2).Текст] = СтрЗначение;
		КонецЕсли;
	КонецЦикла;
	
	Если МногострочныеЧасти.Количество() = 0 Тогда 
		Возврат;
	КонецЕсли;
	
	Для Каждого ДПП Из ДанныеПП Цикл 
		СтрФорма = ДПП.Значение.Форма;
		ДПП.Значение.ДанныеОтчета.Вставить("НесвернутыеДанные", Новый Структура);
		
		Для Каждого Многострочка Из ДПП.Значение.ДанныеОтчета.ДанныеМногострочныхРазделов Цикл 
			ВалидноДляФорм = МногострочныеЧасти[Многострочка.Ключ].ВалидноДляФорм;
			Если ВалидноДляФорм = "*" Или СтрНайти(ВалидноДляФорм, СтрФорма) > 0 Тогда 
				КлючСвертки = Многострочка.Ключ;
				ДПП.Значение.ДанныеОтчета.НесвернутыеДанные.Вставить(КлючСвертки, ДПП.Значение.ДанныеОтчета.ДанныеМногострочныхРазделов[КлючСвертки].Скопировать());
				ДПП.Значение.ДанныеОтчета.ДанныеМногострочныхРазделов[КлючСвертки].Свернуть(МногострочныеЧасти[КлючСвертки].ГрупповыеПоля, МногострочныеЧасти[КлючСвертки].СуммируемыеПоля);
			КонецЕсли;
		КонецЦикла;
	КонецЦикла;
	
	Для Каждого КЗ Из МногострочныеЧасти Цикл
		Ключи = СтроковыеФункцииКлиентСервер.РазложитьСтрокуВМассивПодстрок(КЗ.Значение.ГрупповыеПоля);
		ВалидноДляФорм = КЗ.Значение.ВалидноДляФорм;
		
		ОбластьПравилаПереноса = Макет.Области.Найти(КЗ.Ключ);
		Если ОбластьПравилаПереноса = Неопределено Тогда 
			Продолжить;
		КонецЕсли;
		
		ТаблицаФормы = Форма.РеквизитФормыВЗначение(КЗ.Ключ);
		Для Каждого Стр Из ТаблицаФормы Цикл
			Если Не ВсеКлючиВСтрокеЗаполнены(Стр, Ключи) Тогда 
				Продолжить;
			КонецЕсли;
			
			СтруктураОтбора = Новый Структура;
			Для Каждого Ключ Из Ключи Цикл 
				СтруктураОтбора.Вставить(Ключ, Стр[Ключ]);
			КонецЦикла;
			
			УдаляемыеСтроки = Новый Соответствие;
			
			Для Инд = ОбластьПравилаПереноса.Верх По ОбластьПравилаПереноса.Низ Цикл
				ИдПравило = Макет.Область(Инд, 1, Инд, 1).Текст;
				Если Не ЗначениеЗаполнено(ИдПравило) Тогда 
					Прервать;
				КонецЕсли;
				ПолеИсточник = Макет.Область(Инд, 2, Инд, 2).Текст;
				ПолеПриемник = Макет.Область(Инд, 3, Инд, 3).Текст;
				
				Данные = ДанныеПП[ИдПравило];
				Если ЗначениеЗаполнено(Данные) Тогда
					Если ВалидноДляФорм = "*" Или СтрНайти(ВалидноДляФорм, Данные.Форма) > 0 Тогда 
						ОтобранныеСтроки = Данные.ДанныеОтчета.ДанныеМногострочныхРазделов[КЗ.Ключ].НайтиСтроки(СтруктураОтбора);
						Если ОтобранныеСтроки.Количество() > 0 Тогда 
							Стр[ПолеПриемник] = ОтобранныеСтроки[0][ПолеИсточник];
						Иначе
							Стр[ПолеПриемник] = Неопределено;
						КонецЕсли;
						
						Для Каждого СтрДанные Из ОтобранныеСтроки Цикл
							УдаляемыеСтроки.Вставить(СтрДанные);
						КонецЦикла;
					КонецЕсли;
				КонецЕсли;
			КонецЦикла;
			
			Для Каждого УдаляемаяСтрока Из УдаляемыеСтроки Цикл 
				УдаляемаяСтрока.Ключ.Владелец().Удалить(УдаляемаяСтрока.Ключ);
			КонецЦикла;
		КонецЦикла;
		Форма.ЗначениеВРеквизитФормы(ТаблицаФормы, КЗ.Ключ);
	КонецЦикла;
	
	Для Каждого КЗ Из МногострочныеЧасти Цикл
		Ключи = СтроковыеФункцииКлиентСервер.РазложитьСтрокуВМассивПодстрок(КЗ.Значение.ГрупповыеПоля);
		ПоляОписания = СтроковыеФункцииКлиентСервер.РазложитьСтрокуВМассивПодстрок(КЗ.Значение.ПоляОписания);
		ВалидноДляФорм = КЗ.Значение.ВалидноДляФорм;
		ОбластьПравилаПереноса = Макет.Области.Найти(КЗ.Ключ);
		Если ОбластьПравилаПереноса = Неопределено Тогда 
			Продолжить;
		КонецЕсли;
		
		ТаблицаФормы = Форма.РеквизитФормыВЗначение(КЗ.Ключ);
		ТаблицаДобавления = ТаблицаФормы.Скопировать();
		ТаблицаДобавления.Очистить();
		
		Для Каждого ДПП Из ДанныеПП Цикл
			СтрФорма = ДПП.Значение.Форма;
			Многострочка = ДПП.Значение.ДанныеОтчета.ДанныеМногострочныхРазделов[КЗ.Ключ];
			
			Если ВалидноДляФорм = "*" Или СтрНайти(ВалидноДляФорм, СтрФорма) > 0 Тогда
				Для Каждого Стр Из Многострочка Цикл
					Если Не ВсеКлючиВСтрокеЗаполнены(Стр, Ключи) Тогда 
						Продолжить;
					КонецЕсли;
					
					СтруктураОтбора = Новый Структура;
					Для Каждого Ключ Из Ключи Цикл 
						СтруктураОтбора.Вставить(Ключ, Стр[Ключ]);
					КонецЦикла;
					
					ДобавленаСтрока = Ложь;
					ОтобранныеСтроки = ТаблицаФормы.НайтиСтроки(СтруктураОтбора);
					Если ОтобранныеСтроки.Количество() > 0 Тогда 
						ОтобраннаяСтрока = ОтобранныеСтроки[0];
					Иначе
						ОтобранныеСтроки = ТаблицаДобавления.НайтиСтроки(СтруктураОтбора);
						Если ОтобранныеСтроки.Количество() > 0 Тогда 
							ОтобраннаяСтрока = ОтобранныеСтроки[0];
						Иначе 
							ОтобраннаяСтрока = ТаблицаДобавления.Добавить();
							ДобавленаСтрока = Истина;
						КонецЕсли;
					КонецЕсли;
					
					Если ДобавленаСтрока И ПоляОписания.Количество() > 0 Тогда
						Описания = ДПП.Значение.ДанныеОтчета.НесвернутыеДанные[КЗ.Ключ].НайтиСтроки(СтруктураОтбора);
						
						Если Описания.Количество() > 0 Тогда 
							Описания = Описания[0];
							Для Каждого Поле Из ПоляОписания Цикл 
								ОтобраннаяСтрока[Поле] = Описания[Поле];
							КонецЦикла;
						КонецЕсли;
					КонецЕсли;
					
					Для Инд = ОбластьПравилаПереноса.Верх По ОбластьПравилаПереноса.Низ Цикл
						ИдПравило = Макет.Область(Инд, 1, Инд, 1).Текст;
						Если Не ЗначениеЗаполнено(ИдПравило) Тогда 
							Прервать;
						КонецЕсли;
						
						Если ДПП.Ключ <> ИдПравило Тогда 
							Продолжить;
						КонецЕсли;
						
						ПолеИсточник = Макет.Область(Инд, 2, Инд, 2).Текст;
						ПолеПриемник = Макет.Область(Инд, 3, Инд, 3).Текст;
						ОтобраннаяСтрока[ПолеПриемник] = Стр[ПолеИсточник];
						Для Каждого КЗСтруктураОтбора Из СтруктураОтбора Цикл
							ОтобраннаяСтрока[КЗСтруктураОтбора.Ключ] = КЗСтруктураОтбора.Значение;
						КонецЦикла;
					КонецЦикла;
				КонецЦикла;
			КонецЕсли;
		КонецЦикла;
		Для Каждого Стр Из ТаблицаДобавления Цикл 
			ЗаполнитьЗначенияСвойств(ТаблицаФормы.Добавить(), Стр);
		КонецЦикла;
		
		ИтоговаяТаблица = ТаблицаФормы.Скопировать();
		ИтоговаяТаблица.Очистить();
		Колонки = ИтоговаяТаблица.Колонки;
		Для Каждого Стр Из ТаблицаФормы Цикл 
			ЕстьЗначения = Ложь;
			Для Инд = 0 По Колонки.Количество() - 1 Цикл 
				Если ЗначениеЗаполнено(Стр[Колонки[Инд].Имя]) Тогда
					ЕстьЗначения = Истина;
					Прервать;
				КонецЕсли;
			КонецЦикла;
			Если ЕстьЗначения Тогда 
				ЗаполнитьЗначенияСвойств(ИтоговаяТаблица.Добавить(), Стр);
			КонецЕсли;
		КонецЦикла;
		
		Пока ИтоговаяТаблица.Количество() < Форма.мСтруктураИсхКолвоСтрокРазделов[КЗ.Ключ]  Цикл 
			ИтоговаяТаблица.Добавить();
		КонецЦикла;
		
		Форма.ЗначениеВРеквизитФормы(ИтоговаяТаблица, КЗ.Ключ);
	КонецЦикла;
КонецПроцедуры

Функция ПолучитьДокументПредидущегоПериода(ИсточникОтчета, Организация, Начало, Конец, ТекстОписанияПроблемы, ОбособленноеПодразделение)
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	РегламентированныйОтчет.Ссылка,
		|	РегламентированныйОтчет.ДанныеОтчета,
		|	РегламентированныйОтчет.ВыбраннаяФорма
		|ИЗ
		|	Документ.РегламентированныйОтчет КАК РегламентированныйОтчет
		|ГДЕ
		|	НЕ РегламентированныйОтчет.ПометкаУдаления
		|	И РегламентированныйОтчет.Организация = &Организация
		|	И РегламентированныйОтчет.ДатаНачала МЕЖДУ &ДатаНачала1 И &ДатаНачала2
		|	И РегламентированныйОтчет.ДатаОкончания МЕЖДУ &ДатаОкончания1 И &ДатаОкончания2
		|	И РегламентированныйОтчет.ИсточникОтчета = &ИсточникОтчета";
	
	Запрос.УстановитьПараметр("ДатаНачала1", НачалоДня(Начало));
	Запрос.УстановитьПараметр("ДатаОкончания1", НачалоДня(КонецМесяца(Конец)));
	Запрос.УстановитьПараметр("ДатаНачала2", КонецДня(Начало));
	Запрос.УстановитьПараметр("ДатаОкончания2", КонецДня(КонецМесяца(Конец)));
	Запрос.УстановитьПараметр("ИсточникОтчета", ИсточникОтчета);
	Запрос.УстановитьПараметр("Организация", Организация);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	Результат = Неопределено;
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл 
		Если ЗначениеЗаполнено(ОбособленноеПодразделение) Тогда 
			ДанныеОтчета = ВыборкаДетальныеЗаписи.ДанныеОтчета.Получить();
			Если ДанныеОтчета.Свойство("ОбособленноеПодразделение") И 
				ДанныеОтчета.ОбособленноеПодразделение <> ОбособленноеПодразделение Тогда 
				Продолжить;
			КонецЕсли;
		КонецЕсли;
		
		Если ЗначениеЗаполнено(Результат) Тогда
			ПП = нрег(ПредставлениеПериода(НачалоДня(Запрос.Параметры.ДатаНачала1), КонецДня(Запрос.Параметры.ДатаОкончания1), "ФП = Истина"));
			Текст = "обнаружено несколько отчетов за " + ПП + 
					" для автоматического заполнения оставьте только один (остальные можно пометить на удаление)";
			Если ЗначениеЗаполнено(ТекстОписанияПроблемы) Тогда 
				ТекстОписанияПроблемы = ТекстОписанияПроблемы +Символы.ПС;
			Иначе
				ТекстОписанияПроблемы = "Заполнение отменено: ";
			КонецЕсли;
			ТекстОписанияПроблемы = ТекстОписанияПроблемы + Текст;
			Возврат Неопределено;
		Иначе
			Результат = Новый Структура("ДанныеОтчета,Форма", ВыборкаДетальныеЗаписи.ДанныеОтчета.Получить(), ВыборкаДетальныеЗаписи.ВыбраннаяФорма);
		КонецЕсли;
	КонецЦикла;
	
	Возврат Результат;
КонецФункции

Функция ПолучитьДокументыПредидущихПериодов(Форма, МакетПереноса, ТекстОписанияПроблемы, ОбособленноеПодразделение)
	Результат = Новый Соответствие;
	
	ИсточникОтчета = Сред(Лев(Форма.ИмяФормы, СтрНайти(Форма.ИмяФормы, ".Форма.") - 1), 7);
	Макет = РегламентированнаяОтчетностьВызовСервера.ОбъектОтчета(Форма.ИмяФормы).ПолучитьМакет(МакетПереноса);
	ОбластьПериодов = Макет.Области["Периоды"];
	Если ОбластьПериодов = Неопределено Тогда 
		Возврат Результат;
	КонецЕсли;
	
	Для Инд = ОбластьПериодов.Верх По ОбластьПериодов.Низ Цикл 
		ИдПериода = Макет.Область(Инд, 1, Инд, 1).Текст;
		Если Не ЗначениеЗаполнено(ИдПериода) Тогда 
			Прервать;
		КонецЕсли;
		
		НП = Макет.Область(Инд, 2, Инд, 2).Текст;
		КП = Макет.Область(Инд, 3, Инд, 3).Текст;
		
		НачалоОтчета = ПолучитьДатуПоФормуле(Форма.СтруктураРеквизитовФормы.мДатаНачалаПериодаОтчета, НП);
		КонецОтчета = ПолучитьДатуПоФормуле(Форма.СтруктураРеквизитовФормы.мДатаКонцаПериодаОтчета, КП);
		Если ЗначениеЗаполнено(НачалоОтчета) И ЗначениеЗаполнено(КонецОтчета) Тогда 
			ДокПП = ПолучитьДокументПредидущегоПериода(ИсточникОтчета, Форма.СтруктураРеквизитовФормы.Организация, НачалоОтчета, КонецОтчета, ТекстОписанияПроблемы, ОбособленноеПодразделение);
			Если ЗначениеЗаполнено(ДокПП) Тогда 
				Результат[ИдПериода] = ДокПП;
			КонецЕсли;
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат Результат;
КонецФункции

Функция ПолучитьДатуПоФормуле(ИсходноеЗначение, Формула)
	Если ВРег(Лев(Формула, 3)) = "ВМ:" Тогда 
		ОТ = Новый ОписаниеТипов("Число");
		Сдвиг = ОТ.ПривестиЗначение(Сред(Формула, 4));
		Возврат ДобавитьМесяц(ИсходноеЗначение, -1*Сдвиг);
	КонецЕсли;
	
	Возврат Неопределено;
КонецФункции

Функция ВсеКлючиВСтрокеЗаполнены(СтрокаТаблицы, Ключи)
	Для Каждого Ключ Из Ключи Цикл 
		Если Не ЗначениеЗаполнено(СтрокаТаблицы[Ключ]) Тогда 
			Возврат Ложь;
		КонецЕсли;
	КонецЦикла;
	
	Возврат Истина;
КонецФункции
#КонецОбласти