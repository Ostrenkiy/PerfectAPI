# PerfectAPI
API Layer for Stepik

### TODO:
* Возможность отмены запроса
* Request Adapter и Request Retrier
* Инкапсулировать Alamofire исключительно внутри `RequestMaker` класса. Для этого нам нужно убрать из Api-классов `ParameterEncoding` и `Parameters` типы.
* Инкапсулировать для различных типов запросов `parameterEncoding` и `method`
* Добавить в `RealmPersistenceService` удаление, а также сделать чтение и сохранение асинхронными
