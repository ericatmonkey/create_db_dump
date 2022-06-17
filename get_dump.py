#!/usr/bin/python
import os
import sys


class GetDump(object):

    """
    GetDump DataBase
    Args:
        - db container name (default: 'mauticdb_latest')
        - backend container_name (default: 'automationmonkey_latest')
        - db_name (default: 'mautic')
        - db_user (default: 'root')
        - db_password (default: 'mysecret')

    Output in the current directory:
        - file dump_new.sql
        Folder

    """

    # db container name (I used database via Docker)
    db_container_name = ''
    # backend container_name
    container_name = ''
    # db name
    db_name = ''
    # db user name
    user = ''
    # db user password
    password = ''
    # path to the folder with the script
    path = ''
    # dump file name
    dump_name = ''

    def __init__(
            self,
            db_container_name: str = 'mauticdb_latest',
            container_name: str = 'automationmonkey_latest',
            db_name: str = 'mautic',
            user: str = 'root',
            password: str = 'mysecret',
    ):
        self.db_container_name = db_container_name
        self.container_name = container_name
        self.db_name = db_name
        self.user = user
        self.password = password
        self.dump_name = 'dump_new.sql'
        self.path = os.path.dirname(os.path.abspath(__file__))
        self.files_folder = os.path.dirname(os.path.abspath(__file__)) + '/files/.'

    def get_dump(self):
        """get db dump"""
        script = f'docker exec -i {self.db_container_name} mysqldump -u{self.user} -p{self.password}' \
                 f' --databases {self.db_name} --skip-comments > {self.path}/{self.dump_name}'
        os.system(script)

    def get_media(self):
        """get media files"""
        script = f'docker cp {self.container_name}:/var/www/html/media/files/ {self.path}'
        os.system(script)

    def run(self):
        """run this class"""
        self.get_dump()
        self.get_media()
        print('dump: completed successfully')


if __name__ == '__main__':
    backend_container_name = sys.argv[1]
    db_container_name = sys.argv[2]

    get_dump = GetDump(container_name=backend_container_name, db_container_name=db_container_name)
    get_dump.run()
