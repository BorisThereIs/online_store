from mysql import connector

class UseDatabase:
    # this class implement a context manager protocol in order
    # to establish a connection in a more convenient way

    def __init__(self, config: dict) -> None:
        self.config = config

    def __enter__(self):
        try:
            self.conn = connector.connect(**self.config)
            self.cursor = self.conn.cursor()
            return self.cursor
        except connector.errors.DatabaseError as err:
            print(err)
        except Exception as err:
            print(err)

    def __exit__(self, exc_type, exc_value, exc_trace):
        self.conn.commit()
        self.cursor.close()
        self.conn.close()

        if exc_type is connector.errors.ProgrammingError:
            print(exc_value)

