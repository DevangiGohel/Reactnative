import React, { useState } from "react";
import { StyleSheet, Text, View, Image } from "react-native";
import MaterialCommunityIcons from "react-native-vector-icons/MaterialCommunityIcons";
import { createMaterialBottomTabNavigator } from "@react-navigation/material-bottom-tabs";
import login from "./login";
import { NavigationContainer } from "@react-navigation/native";
import register from "./register";
import Notification from "./notifications";
import APICall from "./apicall";
import mapview from "./mapview";
import {
  createDrawerNavigator,
  DrawerContentScrollView,
  DrawerItemList,
  DrawerItem,
} from "@react-navigation/drawer";
import { log } from "react-native-reanimated";
import drawer from "./drawer";


export default class dashboard extends React.Component {
  render() {
    const Drawer = createDrawerNavigator();
    const Tab = createMaterialBottomTabNavigator();
    return (
      
      <Tab.Navigator
        initialRouteName="drawer"
        activeColor="#ffffff"
        barStyle={{ backgroundColor: "#696969" }}
      >
        <Tab.Screen
          name="Feed"
          component={drawer}
          options={{
            tabBarLabel: "Home",
            tabBarIcon: ({ color = "#696969" }) => (
              <MaterialCommunityIcons name="home" color={color} size={26} />
            ),
          }}
        />
        <Tab.Screen
          name="Fed"
          component={APICall}
          options={{
            tabBarLabel: "ApiCall",
            tabBarIcon: ({ color }) => (
              <MaterialCommunityIcons name="api" color={color} size={26} />
            ),
          }}
        />
        <Tab.Screen
          name="Fee"
          component={Notification}
          options={{
            tabBarLabel: "Notifications",
            tabBarIcon: ({ color }) => (
              <MaterialCommunityIcons name="notification-clear-all" color={color} size={26} />
            ),
          }}
        />

<Tab.Screen
          name="Mapview"
          component={mapview}
          options={{
            tabBarLabel: "Mapview",
            tabBarIcon: ({ color }) => (
              <MaterialCommunityIcons name="google-maps" color={color} size={26} />
            ),
          }}
        />
        
      </Tab.Navigator>
     
    
    )  }
}

const styles = StyleSheet.create({
  container: {
    width: "100%",
    height: "100%",
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
  },
});
