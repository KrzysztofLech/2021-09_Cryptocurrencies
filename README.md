# Zadanie testowe
Wrzesień 2021


## Opis zadania:
* Głównym celem jest pobranie z *api.coinlore.com/api/tickers* listy 20 kryptowalut i wyświetlenie ich w formie listy.
* W projekcie zastosowano architekturę MVVM rozszerzoną o koordynator i dependency injection.


## Realizacja zadania:
Projekt składa się z jednego view kontrolera, który obsługiwany jest przez koordynator.

### 1. Ekran listy (*ListViewController*)
* *view* modułu składa się z dwóch komponentów: *UISegmentedControl* i *UITableView*
* każdy element listy, oprócz nazwy kryptowaluty i jej symbolu, pokazuje dodatkowo: cenę w $, ilość oraz procentowe zmiany ceny z ostatniej godziny i doby
* lista jest odświeżana automatycznie co 30 sekund (**Timer**)
* w sytuacji wystąpienia problemu z pobraniem danych, odliczanie czasu zostaje wstrzymane i zostaje wznowione dopiero po poprawnym odebraniu paczki z danymi
* znajdujący się na górze ekranu SegmentedControl daje możliwość zmiany sposobu sortowania danych - domyślnie po nazwie kryptowaluty
* po każdym kolejnym pobraniu nowych danych, są one porównywane z poprzednio pobranymi (jeśli istnieją), dzięki czemu możliwe jest określenie trendu zmiany ceny
* ceny, które wzrosły pokazane są kolorem żółtym, te które spadły kolorem czerwony
* jeśli endpoint zwróci pustą kolekcję (brak danych) to na liście pojawi się placeholder z stosowną informacją
* pobieranie danych odbywa się w ListViewModel'u - w trakcie trwania tego procesu (na górnej belce, po prawej stronie) pojawia się wskaźnik informujący o tym (*UIActivityIndicatorView*)
* liczba zwróconych przez endpoint kryptowalut jest prezentowana w *title* belki nawigacyjnej

### 2. Koordynator (*RootCoordinator*)
* dzięki zastosowaniu koordynatora możliwe jest przeniesienie części logiki z view controllera
* przykładem jest wyświetlanie alertu z informacją o problemach z pobraniem danych: *ListViewController* nie wyświetla *UIAlertController* - przekazuje o tym informację do koordynataora, który sam decyduje co zrobić (prezentuje alert)

## UI:
* wszystkie elementy UI zostały utworzone w kodzie
* do ich poprawnego rozmieszczenia na ekranie zastosowano *AutoLayout* zrealizowany za pomocą biblioteki **SnapKit**
* do nawigacji pomiędzy kontrolerami wykorzystano *UINavigationController*
* projekt wspiera **Dark Mode**, a kolory wykorzystywane w projekcie są definiowane w *ColorAssets.xcassets*, do których jest dostęp poprzez strukturę *AppColor*

## Networking:
Za warstwę networkingu odpowiada prosty serwis *DataService* oparty o **URLSession**.
W projekcie dane pobierane są tylko z jednego endpoint’u i jednego typu zapytania, nie było więc potrzeby tworzenia bardziej rozbudowanego rozwiązania.

W typowych aplikacjach mobilnych, gdzie wysyłanych jest wiele różnych requestów, zastosowałbym bardziej złożone rozwiązanie, przy czym wspólnym elementem serwisów byłoby odwoływanie się do niego poprzez protokół.

## Error handling:
Podczas pobierania danych z endpointu może wydarzyć się wiele nieprzewidzianych zdarzeń, kończących się niepowodzeniem. Z tego powodu dodano customową obsługę błędów. Celem było:

* informowanie użytkownika o każdym problemie
* umożliwienie użytkownikowi powtórzenia akcji - powtórne wysłanie requestu

## Dependencies:
W projekcie celowo zrezygnowałem z korzystania z *CocoaPods* - dodawanie zewnętrznych bibliotek zrealizowałem poprzez **SPM**.

W projekcie wykorzystana jest tylko jedna biblioteka: **SnapKit**, która wspomaga proces tworzenia widoków za pomocą kodu. Bez problemu mógłbym poradzić sobie bez niej - Apple oferuje kilka natywnych technik tworzenia autolayoutu, są one jednak trochę bardziej czasochłonne.
