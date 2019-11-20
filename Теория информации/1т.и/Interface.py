import pygame as pg
import encription as encr
#from fractions import gcd

pg.init()
screen = pg.display.set_mode((640, 480))
COLOR_INACTIVE = pg.Color('lightskyblue3')
COLOR_ACTIVE = pg.Color('dodgerblue2')
FONT = pg.font.Font(None, 32)

def gcd (a,b):
    while b:
        a,b=b,a%b
    return a

class InputBox:

    def __init__(self, x, y, w, h, text=''):
        self.rect = pg.Rect(x, y, w, h)
        self.color = COLOR_INACTIVE
        self.text = text
        self.txt_surface = FONT.render(text, True, self.color)
        self.active = False

    def handle_event(self, event):
        if event.type == pg.MOUSEBUTTONDOWN:
            # If the user clicked on the input_box rect.
            if self.rect.collidepoint(event.pos):
                # Toggle the active variable.
                self.active = not self.active
            else:
                self.active = False
            # Change the current color of the input box.
            self.color = COLOR_ACTIVE if self.active else COLOR_INACTIVE
        if event.type == pg.KEYDOWN:
            if self.active:
                if event.key == pg.K_RETURN:
                    print(self.text)
                    p=self.text
                    self.text = ''
                    return p
                elif event.key == pg.K_BACKSPACE:
                    self.text = self.text[:-1]
                else:
                    self.text += event.unicode
                # Re-render the text.
                self.txt_surface = FONT.render(self.text, True, self.color)

    def update(self):
        # Resize the box if the text is too long.
        width = max(200, self.txt_surface.get_width()+10)
        self.rect.w = width

    def draw(self, screen,a,b,key):
        # Blit the text.
        screen.blit(self.txt_surface, (self.rect.x+5, self.rect.y+5))
        # Blit the rect.
        pg.draw.rect(screen, self.color, self.rect, 2)
        
        f1 = pg.font.Font(None, 35)
        text1 = f1.render('Enter encripted text :', 1, (180, 0, 0))
        screen.blit(text1, (5, 270))
        
        f2 = pg.font.SysFont(None, 35)
        text2 = f2.render("Input vergin text :", 0, (180, 0, 0))    
        screen.blit(text2, (10, 128))

        f3 = pg.font.SysFont(None, 35)
        text3 = f3.render("After encription : "+a, 0, (0, 180, 0))
        screen.blit(text3, (5, 170))

        f4 = pg.font.SysFont(None, 35)
        text4 = f4.render("After decryption : "+b, 0, (0, 180, 0))
        screen.blit(text4, (5, 410))
        f5 = pg.font.SysFont(None, 35)
        text5 = f5.render("Ek(i)=(i*k)mod n ;    n=26 ", 0, (0, 180, 0))
        screen.blit(text5, (5, 5))
        f6 = pg.font.SysFont(None, 35)
        text6 = f6.render("Enter key : ", 0, (0, 180, 0))
        screen.blit(text6, (5, 35))
        if  gcd(int(key),26)==1:
            f7= pg.font.SysFont(None, 35)
            text7 = f7.render("key is right", 0, (0, 180, 0))
            screen.blit(text7, (5, 55))
        else:
            f8= pg.font.SysFont(None, 35)
            text8 = f8.render("key is wrong", 0, (0, 180, 0))
            screen.blit(text8, (5, 55))
            
            
       
def main():
    clock = pg.time.Clock()
    input_box1 = InputBox(280, 130, 290, 32,)
    input_box2 = InputBox(280, 270, 290, 32)
    input_box3 = InputBox(280, 35, 290, 32)
    input_boxes = [input_box1, input_box2, input_box3]
    value=['a','b','c']
    value1=['','','3']
    
    done = False
    while not done:
        for event in pg.event.get():
            if event.type == pg.QUIT:
                done = True
            for i in range(3):
                value[i]=input_boxes[i].handle_event(event)
                if value[i]!=None:
                    value1[i]=value[i]
        print(value1[0])
        for box in input_boxes:
            box.update()

        screen.fill((30, 30, 30))
        for box in input_boxes:
            box.draw(screen,''.join(encr.encription(value1[0],value1[2])),
                     ''.join(encr.deincription(value1[1],value1[2])),value1[2])
        pg.display.flip()
        clock.tick(30)
    
if __name__ == '__main__':
    main()
    pg.quit()
