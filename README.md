# OTUS_FinalProject

Итоговый проект по курсам OTUS

Идея проекта:
В моем приложении я хочу реализовать возможность оставлять рецензии на альбомы, треки либо собранные плейлисты. 
Реализовывать я собираюсь это через подключенную API Spotify. В приложении будет видны ваши понравившиеся альбомы, исполнители, плейлисты. 
Также можно будет посмотреть рецензии интересных именно для вас людей. 
Это может быть как ваш друг, так и популярная личность, которая бы хотела оставить отзыв на интересную им музыку. 
По-моему мнению этот проект будет интересен пользователям, которые бы хотели открыть для себя новую музыку или узнать, на какой музыке рос ваш любимый артист.
Ведь всегда интересней открывать для себя новые альбомы имеющие предысторию.  

На данный момент мною реализованы следующие возможности:
- Экран авторизации или регистрации(если нет аккаунта) пользователя через spotify.
- Сохранение и refresh полученного токена для поддержки данных из API
- Загружены данные профиля Spotify на отдельном экране
- Отображение названий треков, исполнителей и альбомов при поиске
- Главный экран с отображением ваших альбомов, исполнителей и плейлистов специально для вас
- По нажатию на ячейку отображается отдельный экран с обложкой, на котором в дальнейшем можно будет оставлять и видеть отзывы

К проекту подключены библиотеки:
- SnapKit
- Firebase(Crashlytics, DebugView)
- SDWebImage
