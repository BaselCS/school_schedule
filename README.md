# مكون جداول لجامعة الملك فيصل

![صورة من البرنامج](https://github.com/BaselCS/school_schedule/blob/public-version/assets/%D8%B5%D9%88%D8%B1%D8%A9%20%D9%85%D9%86%20%D8%A7%D9%84%D8%A8%D8%B1%D8%A7%D9%85%D8%AC.png?raw=true)

مشروع مبني على إطار [فلاتر](https://github.com/flutter/flutter) ، يهدف إلى تكوين جداول من بين عدد من المواد المُنحصرة تحت كلية واحدة.

بحكم أنه مبني على فلاتر ، فهو يعمل على كل المنصات تقريباً - تم اختباره على أندرويد ، لينكس ، ويندوز- .


# تنبيه
توقفت عن صيانة المشروع و تطويره ، لمن يرغب يمكنه نسخ المشروع و التعديل عليه كما يريد ، يوجد هنالك قائمة اقتراحات و مشاكل يمكنه البدء منها
# خطوات التحميل 

1. تحميل [فلاتر](https://docs.flutter.dev/get-started/install)  
2. نسخ المشروع من خلال 
```bash
git clone https://github.com/BaselCS/school_schedule.git
```
3. معرفة ما يحتاج لتحديث من خلال 
```bash
flutter pub outdated
```
4. تحديث ما يحتاج لتحديث من خلال 
```
flutter pub upgrade {أسماء الحزم من الأمر السابق}
```
5. الذهاب إلى `lib/web/backend.dart` و تحديث `url` لرابط المناسب لك
6. تشغيل المشروع على المنصة المرغوبة


# اقتراحات تطوير : 
- حل مشكلة إخفاق البرنامج عند السحب السريع .
- حفظ الجداول التي يرغب المستخدم في حظفها .
- حفظ أرقام المواد في حالة رغبة المستخدم في ذلك .
- تحسين الواجهة و جعلها مناسبة للهواتف .

# King Faisal University Schedule Builder
A project built with Flutter, designed to generate study schedules from a set of courses offered under the same college.

Since it’s built using [Flutter](https://github.com/flutter/flutter), so it runs on almost all major platforms — tested on Android, Linux, and Windows.

# Note

This project is no longer actively maintained.
You are welcome to fork the repository and modify it as you wish.
There’s a list of issues and suggestions you can start working on.

# Installation Steps

1. Install Flutter
2. Clone the repository:
`git clone https://github.com/BaselCS/school_schedule.git`

3. Check for outdated dependencies:
`flutter pub outdated`
4. Update the required packages:
`flutter pub upgrade {package_names_from_previous_command}`

4. Open `lib/web/backend`.dart and update the `url` variable to your preferred endpoint.

Run the project on your desired platform.

# Suggested Improvements

- Fix the crash issue that occurs during rapid scrolling.
- Add support for saving favorite schedules.
- Allow saving course numbers for easier reuse.
- Improve the UI to be more mobile-friendly.
