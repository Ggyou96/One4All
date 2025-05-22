from kivy.app import App
from kivy.core.window import Window
from kivy.lang import Builder

Window.clearcolor=(0, 0, 0, 0)
Window.size=(360, 720)

class MyApp(App):
    def build(self):
        return Builder.load_file('myapp.kv')

if __name__ == '__main__':
    MyApp().run()