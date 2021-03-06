# README

**Rest-API для блога с генерацией отчета**

**Авторизация**

Эндпоинта для регистрации нет, поэтому на сервере необхоимо выполнить

    rake db:seed

для создания пользователей и тестовых данных.

Для авторизации необходимо отправить POST запрос:
 post "/api/v1/auth"
 
 Body:
     user: "volt@volt.com"
     password: "pasword123"
 
 в ответе будет получен json c токеном для авторизации. 
 
 В последующих запросах к API данный токен подставляется в заголовки с ключом Authorization
 и значением "Bearer #{значение токена}"
 
 **Эндпоинты:**
 
 **Создание поста:**
 
    Запрос    
        POST "/api/v1/posts.json"
        Body: 
          title: "Заголовок"
          body: "Контент"
          published_at: "время и дата в формате iso 8601"
          `если published_at не будет в запросе, будет использовано текущее время\дата` 
   
    Ответ:
      Содержит JSON вида:
      * id - номер поста
      * title - заголовок поста
      * body - тело поста
      * published_at - дата/время публикации
      * author_nickname - nickname автора
      
 **Список постов:**
    
    Запрос    
            GET "/api/v1/posts.json"
            params: 
              page: "номер страницы"
              per_page: "желаемое количество записей на странице"            
            `если не указать параметры, будет возвращена вся коллекция`    
        Ответ:
            Заголовки:
                 total_pages - всего страниц
                 total_posts - всего постов
          Содержит массив обьектов  вида:            
            каждый обьект содержит:
          * id - номер поста
          * title - заголовок поста
          * body - тело поста
          * published_at - дата/время публикации
          * author_nickname - nickname автора
 **Отдельный пост:**
    
    Запрос    
         GET "/api/v1/posts/:post_id.json"
    Ответ:
       Содержит JSON вида:
          * id - номер поста
          * title - заголовок поста
          * body - тело поста
          * published_at - дата/время публикации
          * author_nickname - nickname автора
            
    
 **Аналитический отчет:**
    
    Запрос    
      POST "/api/v1/reports/by_author.json"
      params:
        start_date: Дата в формате iso 8601
        end_date: Дата в формате iso 8601
        email: Указать email для доставки отчета.
    Ответ:
        json: "message": "Report generation started"
        
        
 
 **Загрузка аватара(веб-интерфейс):**
 
    Загрузить аватар для пользователя можно по адресу:
        "/avatar"?token="полученный через API токен"
    
 Example: volt-posts-api.herokuapp.com