#!/usr/bin/env python

from math import pi, sin, cos

from direct.showbase.ShowBase import ShowBase
from direct.actor.Actor import Actor
from direct.task import Task
from direct.interval.IntervalGlobal import Sequence
from panda3d.core import Point3, WindowProperties, Vec4, Vec3, KeyboardButton

import sys


class Game(ShowBase):

    def __init__(self):
        self.keyMap = {
            "forward": KeyboardButton.ascii_key('w'),
            "backward": KeyboardButton.ascii_key('s'),
            "left": KeyboardButton.ascii_key('a'),
            "right": KeyboardButton.ascii_key('d'),
        }
        ShowBase.__init__(self)
        self.setWindowProps()

        self.scene = self.loader.loadModel("models/environment")
        self.scene.reparentTo(self.render)

        self.scene.setScale(0.25, 0.25, 0.25)
        self.scene.setPos(0, 0, 0)

        self.pandaActor = Actor("models/panda-model",
                                {"walk": "models/panda-walk4"})
        self.pandaActor.setScale(0.005, 0.005, 0.005)
        self.pandaActor.setPos(0, -55, 0)
        self.pandaActor.setH(-180)
        self.pandaActor.reparentTo(self.render)

        self.camera.setPos(-25, -60, 1.5)
        self.camera.setH(-70)

        self.accept("w", self.updateKeyMap, ["up", True])
        self.accept("w-up", self.updateKeyMap, ["up", False])
        self.accept("s", self.updateKeyMap, ["down", True])
        self.accept("s-up", self.updateKeyMap, ["down", False])

        self.taskMgr.add(self.move_player, "move")

    def move_player(self, task):
        is_down = self.mouseWatcherNode.is_button_down
        frameTime = globalClock.getFrameTime()

        if is_down(self.keyMap["forward"]):
            # self.pandaActor.
            self.pandaActor.setPos(self.pandaActor.getPos() + Vec3(0, 0.002, 0))
        if is_down(self.keyMap["backward"]):
            self.pandaActor.setPos(self.pandaActor.getPos() + Vec3(0, -0.002, 0))
        if is_down(self.keyMap["left"]):
            self.pandaActor.setH(self.pandaActor.getH() + 0.1)
        if is_down(self.keyMap["right"]):
            self.pandaActor.setH(self.pandaActor.getH() + -0.1)

        return task.cont

    def update(self, task):
        return task.cont

    def updateKeyMap(self, controlName, controlState):
        self.keyMap[controlName] = controlState

    def setWindowProps(self):
        properties = WindowProperties()
        properties.cursor_hidden = False

        self.disableMouse()
        self.accept('escape', sys.exit)
        self.win.requestProperties(properties)


def main():
    game = Game()
    game.run()
