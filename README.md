# SOC-support-system

install pipenv -->
GOTO base Project path ie, backend -->
$pipenv shell -->
install postgress and set as per backend/setting.py database str -->
$python manage.py makemigration -->
$python manage.py migrate -->
$python manage.py runserver -->
browse to  "http://127.0.0.1:8000/"-->
this list out all urls -->
1. admin/ : not in use -->
2. auth/ : for user register/login -->
    2i. "http://127.0.0.1:8000/auth/login/" : for login -->
    2ii."http://127.0.0.1:8000/auth/register/": for register -->
3."http://127.0.0.1:8000/api/v1/" : gives auth prediction base urls list -->
    3i. "http://127.0.0.1:8000/api/v1/authpredict/": for signle line log prediction -->
        -> simply pass [POST]: log data ie 
            -> "Nov bla bla bala "
            example response:
                [
                    {
                        "log": "Nov 30 09:22:03 ip-172-31-27-153 sshd[22218]: Did not receive identification string from 196.200.90.236",
                        "label": "anomaly"
                    }
                ]
    3ii. "http://127.0.0.1:8000/api/v1/logfiles/" : list all dataset files -->
            -> check response [GET] 
        example:
            [
                {
                    "date": "2022-07-04 04:21:22",
                    "path": "/home/iamdpk/Project Work/SOC-support-system/Dataset/auth.log"
                },
                {
                    "date": "2022-07-04 04:21:22",
                    "path": "/home/iamdpk/Project Work/SOC-support-system/Dataset/newfile.txt"
                },
                {
                    "date": "2022-07-04 04:21:22",
                    "path": "/home/iamdpk/Project Work/SOC-support-system/Dataset/auth.csv"
                }
            ]
    3iii "http://127.0.0.1:8000/api/v1/data/" : save result ie csv and json into respective file -->
            -> [POST] :
            {
                "date": "2022-07-04 04:21:22",
                "path": "/home/iamdpk/Project Work/SOC-support-system/Dataset/auth.log"
            }
            ^^^^^^^^^ : this post data get from 3ii response

            this gives response as
            exapmle :
                {
                    "csv_path": "/home/iamdpk/Project Work/SOC-support-system/Predicted Results/Auth Log/csv//auth_2022_07_04__23_03_06.csv",
                    "json_path": "/home/iamdpk/Project Work/SOC-support-system/Predicted Results/Auth Log/json//auth_2022_07_04__23_03_08.json"
                } 
            ^^^^^^ check this file path for   🤔
