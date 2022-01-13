import { StatusBar } from "expo-status-bar";
import React from "react";
import Splash from "./Screens/Splashscreen/splash";
import login from "./Screens/login";
import screenshot from "./Screens/screenshot";
import Register from "./Screens/register";
import Drawer from "./Screens/drawer";
import Dashboard from "./Screens/dashboard";
import Icon from "react-native-vector-icons/MaterialCommunityIcons";
import { DrawerActions } from "@react-navigation/native";
import * as TaskManager from 'expo-task-manager';
import * as Location from 'expo-location';
import firebase from "firebase";

// if (!firebase.apps.length) {
//   firebase.initializeApp(firebaseConfig);
// } else {
//   firebase.app(); // if already initialized, use that one
// }

import {
  StyleSheet,
  Text,
  View,
  TextInput,
  TouchableOpacity,
} from "react-native";
import { NavigationContainer } from "@react-navigation/native";
import { createStackNavigator } from "@react-navigation/stack";

const firebaseConfig = {
  apiKey: "AIzaSyA5B0lewWwjN-b-9i9fBs9PD4Qrkh-5Zhk",
  authDomain: "flutterauth-12675.firebaseapp.com",
  databaseURL: "https://flutterauth-12675-default-rtdb.firebaseio.com",
  projectId: "flutterauth-12675",
  storageBucket: "flutterauth-12675.appspot.com",
  messagingSenderId: "580633995394",
  appId: "1:580633995394:web:8aa13fb3ac9751fb52ec9b",
  measurementId: "G-JP277SZC7Y",
};
firebase.initializeApp(firebaseConfig);
//firebase.analytics();
const Stack = createStackNavigator();
const LOCATION_TASK_NAME = 'background-location-task';

export default class App extends React.Component {

  


  render() {
    return (
      <NavigationContainer>
        <NavStack />
      </NavigationContainer>
    );
  }
}

const NavStack = ({ navigation }) => (
  <Stack.Navigator>
    <Stack.Screen
      name="Splash"
      options={{ headerShown: false }}
      component={Splash}
    />
    <Stack.Screen
      name="Login"
      component={login}
      options={{ headerShown: false }}
    />
    <Stack.Screen
      name="SS"
      component={screenshot}
      options={{ headerShown: false }}
    />
    <Stack.Screen
      name="register"
      component={Register}
      options={{ headerShown: false }}
    />
    
    <Stack.Screen
      name="dashboard"
      options={({ navigation }) => ({
        title: "Side Navigation",
        headerStyle: { backgroundColor: "#FFFFFF" },
        headerLeft: () => (
          <Icon
            style={{ marginLeft: 15, color: "#000000" }}
            name={"menu"}
            size={25}
            onPress={() => navigation.dispatch(DrawerActions.openDrawer())}
          />
        ),
      })}
      component={Dashboard}
      
    />
    
    
    <Stack.Screen
      name="drawer"
      options={({ navigation }) => ({
        title: "Side Navigation",
        headerStyle: { backgroundColor: "#FFFFFF" },
        headerLeft: () => (
          <Icon
            style={{ marginLeft: 15, color: "#000000" }}
            name={"menu"}
            size={25}
            onPress={() => navigation.dispatch(DrawerActions.openDrawer())}
          />
        ),
      })}
      component={Drawer}
    />
  </Stack.Navigator>
);
