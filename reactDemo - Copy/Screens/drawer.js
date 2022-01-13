import React,{ Component, useEffect, useRef, useState } from "react";
import { View, Text, Button, CheckBox, Picker } from "react-native";
import { NavigationContainer } from "@react-navigation/native";
import { RadioButton } from "react-native-paper";
import {
  createDrawerNavigator,
  DrawerContentScrollView,
  DrawerItemList,
  DrawerItem,
} from "@react-navigation/drawer";
import { Header } from "react-native/Libraries/NewAppScreen";
import Constants from 'expo-constants';
//import { Dropdown }from 'react-native-material-dropdown';
import ModalDropdown from 'react-native-modal-dropdown';
import Animated from "react-native-reanimated";
function Feed({ navigation }) {
  return (
    <ModalDropdown
     style={{borderColor:"#ffff", borderBottomWidth: 2, flex: 1, alignItems: 'center',  justifyContent: 'space-around' }} 
     options={['option 1', 'option 2', 'option 3', 'option 4', 'option 5']}
     >
     
     </ModalDropdown>
  );
}


function Notifications() {

  return (
    <View><Text>Hii</Text></View>
  );
}


function CustomDrawerContent(props) {
  return (
    <DrawerContentScrollView {...props}>
      <DrawerItemList {...props} />
      <DrawerItem
        label="Close drawer"
        onPress={() => props.navigation.closeDrawer()}
      />
      <DrawerItem
        label="Toggle drawer"
        onPress={() => props.navigation.toggleDrawer()}
      />
    </DrawerContentScrollView>
  );
}

const Drawer = createDrawerNavigator();

function MyDrawer() {
  return (
    <Drawer.Navigator
      drawerContent={(props) => <CustomDrawerContent {...props} />}
    >
      <Drawer.Screen name="Feed" component={Feed} />
      <Drawer.Screen name="Notifications" component={Notifications} />
    </Drawer.Navigator>
  );
}

export default class drawer extends React.Component {
  render() {
    return <MyDrawer />;
  }
}
